require 'nokogiri'

class DHData < Middleman::Extension
  def initialize(app, options_hash = {}, &block)
    super
  end

  def after_configuration
    #@app.sitemap.register_resource_list_manipulator(:"dhdata_sitemap_management", self, false)
    
  end

  def manipulate_resource_list(resources)
    return resources if @resource_list_manipulated
    resources.select{ |p| p.path =~ /^content\// && !p.data.published }.each do |resource|
      @app.ignore resource.path
    end
    
    @resource_list_manipulated = true
    #resources = @app.sitemap.resources
    content = resources.select{|p| p.path =~ /^content\// && p.data.published }.group_by { |p| p.path.split('/')[1] }
    ['categories', 'recipes', 'organizations', 'datasets', 'groups'].each do |section|
      content[section] = [] if content[section].nil?
    end

    category_names = []

    content['categories'].each do |page|
      category = page.path.split('/').last.sub(/\.html$/, '')
      category_names << category
      @app.proxy "/cookbook/#{category}/index.html", page.path, :ignore => true
      @app.ignore page.path
    end


    content['recipes'].group_by { |p| p.data.category }.each do |category, pages|
      if "#{category}" != "" && category_names.include?(category)
        pages.each do |page|
          recipe_name = page.path.split(/\//).last
          @app.proxy "/cookbook/#{category}/#{recipe_name}", page.path, :ignore => true
          @app.ignore page.path
        end
      end
    end

    content['organizations'].each do |page|
      @app.proxy "/organization/#{page.path.split(/\//).last}", page.path, :ignore => true
      @app.ignore page.path
    end
    content['datasets'].each do |page|
      @app.proxy "/dataset/#{page.path.split(/\//).last}", page.path, :ignore => true
      @app.ignore page.path
      # This is where we should add paths to 'virtual' pages for resource previews
    end
    content['groups'].each do |page|
      @app.proxy "/group/#{page.path.split(/\//).last}", page.path, :ignore => true
      @app.ignore page.path
    end
    #@app.sitemap.resources
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

    def find_organization(name)
      find_organizations().
        select{ |o| 
          o.
            path.
            sub(/\/?index.html$/, '').
            split(/\//).
            last.
            sub(/\.html$/, '') == name 
        }.
        first
    end

    def find_groups()
      sitemap.where(:layout.equal => 'group', :published.equal => true).all
    end

    def find_datasets()
      sitemap.where(:layout.equal => 'dataset', :published.equal => true).all
    end

    def find_datasets_for_group(current_page)
      bits = current_page.render({:layout => false}).split(/<\/?h2.*?>/)
      datasets = Hash[
        find_datasets().map { |d| [ d.path.sub(/\.(md|html)$/, '').split(/\//).last, d ]}
      ]

      if bits.length > 2
        content = bits[2].strip
        doc = Nokogiri::HTML::DocumentFragment.parse("<html><body>#{content}</body></html>")
        doc.css('li').map { |item|
          datasets[item.inner_text.to_s.strip]
        }
      else
        []
      end
    end
          

    def find_recipes()
      sitemap.where(:layout.equal => 'recipe', :published.equal => true).all.select{ |p| p.data.category != 'uncategorized' }
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
      content[2][/^\s+/] = ''
      content[2][/\s+$/] = ''
      content = content[2].split(/<\/?h3>/)
      content.shift
      resources = []
      (content.length/2).times do |i|
        doc = Nokogiri::HTML::DocumentFragment.parse("<html><body>#{content[2*i+1]}</body></html>")
        resource = {
          :title => content[2*i],
          :description => doc.css('p').map{ |x| x.to_s }.join('')
        }

        doc.css('tr').each do |row|
          key, value = row.xpath('./td')
          if !key.nil?
            key = key.inner_text.to_s.strip
            value = value.inner_html.to_s.strip
            resource[key.to_sym] = value
          end
        end
        resources.push resource
      end
      # pull out the resources -- after the first <h2>...</h2>
      # each resource is of the pattern:
      # <h3>...</h3>
      # (<p>text...</p>)*
      # <table>...</table>
      resources
    end

    def make_outline_nav(pages)
      ret = "<ul>"
      pages.select{ |p| p.data.published }.each do |page|
        ret += "<li><a href='#{['/', page.path].join('')}'>#{page.data.title}</a>"
        if page.children.select{ |p| p.data.published }.length > 0 then
          ret += make_outline_nav(page.children.sort_by(&:path))
        end
        ret += "</li>"
      end
      ret += "</ul>"
      ret
    end

    def make_breadcrumb_nav(page, as_select = false)
      if page.parent then
        ret = make_breadcrumb_nav(page.parent, as_select)
        if as_select then
          ret += "<option value='#{['/', page.path ].join('')}'>#{truncate(page.data.title, 30)}</option>"
        else
          ret += "<li><a href='#{['/', page.path ].join('')}'>#{truncate(page.data.title, 30)}</a></li>"
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

    def make_cookbook_nav(page, opts = {})
      opts = { :include_up => true, :include_siblings => true, :title => 'Sections' }.merge(opts)
      ret = ''
      if page.children.select{ |p| p.data.published }.length > 0 then
        ret += "<h3>#{opts[:title]}</h3><ul class='list-unstyled'>"
        page.children.select{ |p| p.data.published }.sort_by(&:path).each do |child|
          ret += "<li><a href='#{['/', child.path].join('')}'>#{child.data.title}</a></li>"
        end
        ret += "</ul>"
      end

      ret += "<div class='row'>"
      
      siblings = page.parent.children.select{ |p| p.data.published }.sort_by(&:path)
      paths = siblings.map{|p| p.path}

      current_page_pos = paths.index(page.path)

      ret += "<div class='col-sm-4 text-left'>"
      if !current_page_pos.nil? && opts[:include_siblings] && current_page_pos > 0 then
        ret += "<a href='" + [ '/', siblings[current_page_pos-1].path ].join('') + "'>" + 
               siblings[current_page_pos-1].data.title + "</a>"
      end
      ret += "</div><div class='col-sm-4 text-center'>"
      if opts[:include_up] then
        ret += "<a href='" + [ '/', page.parent.path ].join('') + "'>up</a>"
      end
      ret += "</div><div class='col-sm-4 text-right'>"
      if !current_page_pos.nil? && opts[:include_siblings] && current_page_pos < siblings.length-1 then
        ret += "<a href='" + [ '/', siblings[current_page_pos+1].path ].join('') + "'>" +
               siblings[current_page_pos+1].data.title + "</a>"
      end
      ret += "</div></div>"
      ret
    end
  end
end

::Middleman::Extensions.register(:dh_data, DHData)