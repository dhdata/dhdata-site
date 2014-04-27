require 'nokogiri'

class DHData < Middleman::Extension
  def initialize(app, options_hash = {}, &block)
    super
    @category_names = []
  end

  def after_configuration
    #@app.sitemap.register_resource_list_manipulator(:"dhdata_sitemap_management", self, false)
    # do self-consistency check
  end

  def get_content_resources resources
    content_resources = resources.
                          select{ |p| p.path.start_with?("content/") }.
                          partition{ |p| p.data.published }
    content_resources.last.each do |resource|
      @app.ignore resource.path
    end
    content_resources.first
  end

  def process_categories categories
    categories.each do |page|
      category = page.path.split('/').last.sub(/\.html$/, '')
      @category_names << category
      @app.proxy "/cookbook/#{category}/index.html", page.path, :ignore => true
      @app.ignore page.path
    end
  end

  def process_recipes recipes
    recipes.group_by { |p| p.data.category }.each do |category, pages|
      if "#{category}" != "" && @category_names.include?(category)
        pages.each do |page|
          recipe_name = page.path.split(/\//).last
          @app.proxy "/cookbook/#{category}/#{recipe_name}", page.path, :ignore => true
          @app.ignore page.path
        end
      end
    end
  end

  def manipulate_resource_list(resources)
    if !@resource_list_manipulated
      @resource_list_manipulated = true

      content = get_content_resources(resources).group_by { |p| p.path.split('/').drop(1).first }

      process_categories content['categories'] if !content['categories'].nil?

      process_recipes content['recipes'] if !content['recipes'].nil?

      %w(organizations datasets groups).each do |part|
        if content[part]
          part_path = part.sub(/s$/,'')
          content[part].each do |page|
            @app.proxy "/#{part_path}/#{page.path.split(/\//).last}", page.path, :ignore => true
            @app.ignore page.path
          end
        end
      end
    end
    resources
  end

  helpers do

    def counter(count, text)
      t = text
      s = count == 1 ? '' : 's'
      t['%d'] = count.to_s if t['%d']
      t['%s'] = s if t['%s']
      t
    end

    def truncate(text, length)
      if text.length > length
        text = text[0..length-1]
        text += "&hellip;"
      end
      text
    end

    # current_page should be the organization's page
    # the organization's id is the last component of the page's path without the file extension(s)
    def find_datasets_for_organization(current_page)
      org_id = current_page.path.split('/').last.split('.').first
      sitemap.where(:layout.equal => 'dataset', :published.equal => true, :organization => org_id).all
    end

    def find_organizations()
      sitemap.where(:layout.equal => 'organization', :published.equal => true).all
    end

    # the path should be /organization/#{name}.html or /organization/#{name}/index.html
    def find_organization(name)
      find_organizations().
        select{ |o|
          o.path == "/organization/#{name}.html" ||
          o.path == "/organization/#{name}/index.html"
        }.
        first
    end

    def find_by_layout layout
      sitemap.where(:layout.equal => layout, :published.equal => true).all
    end

    def find_groups()
      @groups ||= find_by_layout 'group'
    end

    def find_datasets()
      @datasets ||= find_by_layout 'dataset'
    end

    def datasets_by_name()
      @datasets_hash ||= find_datasets().inject({}) { |h, d|
        h[d.path.sub(/\.(md|html)$/, '').split(/\//).last] = d
        h
      }
    end

    def find_datasets_for_group(current_page)
      bits = current_page.render({:layout => false}).split(/<\/?h2.*?>/)

      datasets = datasets_by_name

      if bits.length > 2
        content = bits[2].strip
        doc = Nokogiri::HTML::DocumentFragment.parse("<html><body>#{content}</body></html>")
        doc.css('li').map { |item|
          datasets[item.inner_text.to_s.strip]
        }.compact
      else
        []
      end
    end


    def find_recipes()
      @recipes ||= sitemap.where(:layout.equal => 'recipe', :published.equal => true).all.select{ |p| p.data.category != 'uncategorized' }
      @recipes
    end

    def dataset_tags()
      find_datasets.map { |d| d.data.tags || []}.flatten.uniq
    end

    def recipe_categories()
      sitemap.resources.select{|p| p.data.layout == 'recipe_collection' && p.data.published }.map { |c|
        {
          :name => c.data.title,
          :value => c.path.sub(/\/?index.html$/, '').split('/').last
        }
      }
    end

    def resources_for_dataset(dataset)
      # pull out the resource list
      # doing this with the rendered content allows the original to be in a number of formats
      content = dataset.render({:layout => false}).split(/<\/?h2>/)
      if content.length < 3
        return []
      end
      content = content[2].strip.split(/<\/?h3>/).drop(1)
      resources = []
      (content.length/2).times do |i|
        doc = Nokogiri::HTML::DocumentFragment.parse("<html><body>#{content[2*i+1]}</body></html>")
        resource = {
          :title => content[2*i],
          :description => doc.css('p').map{ |x| x.to_s }.join('')
        }

        resources << doc.css('tr').inject(resource) do |r, row|
          key, value = row.xpath('./td')
          if !key.nil?
            key = key.inner_text.to_s.strip
            value = value.inner_html.to_s.strip
            r[key.to_sym] = value
          end
          r
        end
      end
      # pull out the resources -- after the first <h2>...</h2>
      # each resource is of the pattern:
      # <h3>...</h3>
      # (<p>text...</p>)*
      # <table>...</table>
      resources
    end

    def make_outline_nav(pages, opts = {})
      opts = { :make_links => true, :include_children => true }.merge(opts)
      ret = "<ul>"
      pages.select{ |p| p.data.published }.each do |page|
        if opts[:make_links]
          ret += "<li>" + link_to_page(page)
        else
          ret += "<li>#{page.data.title}</li>"
        end
        if opts[:include_children] && page.children.select{ |p| p.data.published }.length > 0 then
          ret += make_outline_nav(page.children.sort_by(&:path), opts)
        end
        ret += "</li>"
      end
      ret += "</ul>"
      ret
    end

    def make_breadcrumb_nav(page, as_select = false)
      if page.parent then
        ret = make_breadcrumb_nav(page.parent, as_select)
        url = ['/', page.path ].join('')
        title = truncate(page.data.title, 30)
        if as_select then
          ret += "<option value='#{url}'>#{title}</option>"
        else
          ret += "<li><a href='#{url}'>#{title}</a></li>"
        end
      else
        if as_select then
          ret = "<option value='/'>Home</option>"
        else
          ret = "<li><a href='/'>Home</a></li>"
        end
      end
      ret
    end

    def link_to_page page
      if page.nil?
        ""
      else
        "<a href='" + [ '/', page.path ].join('') + "'>" + page.data.title + "</a>"
      end
    end

    def get_siblings page
      page.parent.children
    end

    def make_cookbook_nav(page, opts = {})
      opts = { :list_classes => 'list-unstyled', :include_up => true, :include_siblings => true, :include_children => true, :title => 'Sections' }.merge(opts)
      ret = ''
      if opts[:include_children] && page.children.select{ |p| p.data.published }.length > 0
        ret << "<h3>#{opts[:title]}</h3><ul class='#{opts[:list_classes]}'>"
        page.children.select{ |p| p.data.published }.sort_by(&:path).each do |child|
          ret << "<li>#{link_to_page(child)}</li>"
        end
        ret << "</ul>"
      end

      ret << "<div class='row'>"

      siblings = get_siblings(page).
                   select{ |p| p.data.published }.
                   sort_by(&:path)

      current_page = siblings.bsearch { |p| p.path >= page.path }
      if current_page.nil?
        current_page_pos = nil
      else
        current_page_pos = siblings.index(current_page)
      end

      ret << "<div class='col-sm-4 text-left'>"

      if !current_page_pos.nil? && opts[:include_siblings] && current_page_pos > 0
        ret << link_to_page(siblings[current_page_pos-1])
      end

      ret << "</div><div class='col-sm-4 text-center'>"

      ret << "<a href='" + [ '/', page.parent.path ].join('') + "'>up</a>" if opts[:include_up]

      ret << "</div><div class='col-sm-4 text-right'>"

      if !current_page_pos.nil? && opts[:include_siblings] && current_page_pos < siblings.length-1
        ret << link_to_page(siblings[current_page_pos+1])
      end
      ret << "</div></div>"
      ret
    end

    def star_line n
      '<span class="gold">' + ('&#10029;' * n) + '</span>'
    end

    def stars(min, max = nil)
      range = [ min, max ].compact.sort.uniq
      range_q = range.length > 1
      ret = "<span title='#{range.first}"

      ret << "-#{range.last}" if range_q

      ret << " star" << (range.last == 1 ? "" : "s") << "'>"

      ret << star_line(range.first)

      ret << '(' << star_line(range.last - range.first) << ')' if range_q

      ret << '</span>'

      ret
    end
  end
end

::Middleman::Extensions.register(:dh_data, DHData)
