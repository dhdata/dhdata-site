###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

$:.unshift './lib'
require 'dh_data'

activate :dh_data

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

activate :syntax

set :markdown_engine, :redcarpet
set :markdown,
      :smartypants => true,
      :fenced_code_blocks => true,
      :footnotes => true,
      :strikethrough => true,
      :disabe_indented_code_blocks => true,
      :tables => true,
      :no_intra_emphasis => true,
      :no_styles => true

#require 'middleman-blog'

#activate :directory_indexes

ready do
  %w(cookbook guide).each do |layout|
    sitemap.resources.select { |p| p.data.layout == layout }.each do |book|
      proxy "print/" + book.path, book.path, :layout => layout+'-print', :locals => {
        :current_page => book
      }
    end
  end
end


# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :haml, {
      :ugly => true,
      :format => :xhtml
    }

sprockets.append_path File.join "#{root}", "bower_components"

I18n.enforce_available_locales = false

page "/api/v1/*", :layout => false

page "/sitemap.xml", :layout => false

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :imageoptim do |options|
    options.pngout_options = false
    options.optipng_options = false
    options.advpng_options = false
    options.jpegoptim_options = false
    options.jpegtran_options = false
    options.gifsicle_options = false
  end

  # Enable cache buster
  # activate :asset_hash, :ignore => [ %r{^(images|fonts)/.*} ]

  activate :gzip

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
