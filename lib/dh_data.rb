class DHData < Middleman::Extension
  def initialize(app, options_hash = {}, &block)
    super
  end

  helpers do
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
          ret += "<option value='#{['/', page.path ].join('')}'>#{page.data.title}</option>"
        else
          ret += "<li><a href='#{['/', page.path ].join('')}'>#{page.data.title}</a></li>"
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
      current_page_pos = siblings.index(page)
      ret += "<div class='col-sm-4 text-left'>"
      if opts[:include_siblings] && current_page_pos > 0 then
        ret += "<a href='" + [ '/', siblings[current_page_pos-1].path ].join('') + "'>" + 
               siblings[current_page_pos-1].data.title + "</a>"
      end
      ret += "</div><div class='col-sm-4 text-center'>"
      if opts[:include_up] then
        ret += "<a href='" + [ '/', page.parent.path ].join('') + "'>up</a>"
      end
      ret += "</div><div class='col-sm-4 text-right'>"
      if opts[:include_siblings] && current_page_pos < siblings.length-1 then
        ret += "<a href='" + [ '/', siblings[current_page_pos+1].path ].join('') + "'>" +
               siblings[current_page_pos+1].data.title + "</a>"
      end
      ret += "</div></div>"
      ret
    end
  end
end

::Middleman::Extensions.register(:dh_data, DHData)