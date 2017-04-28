activate :directory_indexes

# default asset directories
set :js_dir,  'assets/js'
set :css_dir, 'assets/css'


# layouts and file-types
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/index.html', layout: 'default'


# development env
configure :development do
  activate :livereload
  activate :asset_hash
end

# production env
configure :production do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
end

# build task
configure :build do

end


# external asset pipeline
activate :external_pipeline,
  name: :brunch,
  command: build? ?
    "NODE_ENV=#{config[:environment]} ./node_modules/brunch/bin/brunch build --production --env #{config[:environment]}" :
    "NODE_ENV=#{config[:environment]} ./node_modules/brunch/bin/brunch watch --stdin --env #{config[:environment]}",
  source: ".tmp/dist",
latency: 1


#after_build do |builder|
#  # add event after build
#  #Ex.: exit 1 unless builder.run 'karma start karma.config.js --single-run'
#end

