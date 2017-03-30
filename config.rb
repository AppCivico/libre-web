# Adding node directory for middleman
#import_path File.expand_path('node_modules', app.root)

###
# Prepare assets for middleman application
###
Vendor = Struct.new(:name, :source, :destination)
vendors = [
  {name: "jquery", source: "./node_modules/jquery/dist/jquery.js", destination: "./source/javascripts/_vendor/jquery.js"},
  {name: "moment", source: "./node_modules/moment/moment.js", destination: "./source/javascripts/_vendor/moment.js"},
  {name: "mustache", source: "./node_modules/mustache/mustache.js", destination: "./source/javascripts/_vendor/mustache.js"},
  {name: "store", source: "./node_modules/store/dist/store.modern.js", destination: "./source/javascripts/_vendor/store.js"},
  {name: "turbolinks", source: "./node_modules/turbolinks/dist/turbolinks.js", destination: "./source/javascripts/_vendor/turbolinks.js"},
]

vendors.each do |v|
  system "cp -f #{v[:source]} #{v[:destination]} &>/dev/null"
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
page '/index.html', layout: 'default'


# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
activate :sprockets
activate :directory_indexes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload

  activate :asset_hash do |opts|
    # ignore email headers
    opts.ignore = [/images\/emails\//i, /\.pdf/i]
  end

end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  activate :asset_hash do |opts|
    # ignore email headers
    opts.ignore = [/images\/emails\//i, /\.pdf/i]
  end

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end
