# directory indexes
# - convert 'app.html.erb' file to 'app/index.html'
activate :gzip
activate :directory_indexes


# default asset directories
set :js_dir,  'assets/js'
set :css_dir, 'assets/css'


# layouts and file-types
page '/*.xml', layout: false
page '/*.js', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/sdk*', layout: false
page '/index.html', layout: 'default'




# development env
configure :development do
  activate :livereload
  activate :asset_hash,
    ignore: [
      /^sdk/,
      /^assets\/sdk/
    ]
end

# production env
configure :production do
  activate :asset_hash, ignore: [/^sdk/, /^assets\/sdk/]
  #activate :minify_css
  #activate :minify_javascript

  activate :imageoptim do |options|
    # Use a build manifest to prevent re-compressing images between builds
    options.manifest = true

    # Silence problematic image_optim workers
    options.skip_missing_workers = true

    # Cause image_optim to be in shouty-mode
    options.verbose = false

    # Setting these to true or nil will let options determine them (recommended)
    options.nice = true
    options.threads = true

    # Image extensions to attempt to compress
    options.image_extensions = %w(.png .jpg .gif .svg)

    # Compressor worker options, individual optimisers can be disabled by passing
    # false instead of a hash
    options.advpng    = { :level => 4 }
    options.gifsicle  = { :interlace => false }
    options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
    options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
    options.optipng   = { :level => 6, :interlace => false }
    options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
    options.pngout    = { :copy_chunks => false, :strategy => 0 }
    options.svgo      = {}
  end
end

# build task
configure :build do

end


# external asset pipeline
activate :external_pipeline,
  name: :webapp,
  command: build? ?
    "export MMPROJECT=default; LOGGY_STACKS=1 ./node_modules/brunch/bin/brunch build --env #{config[:environment]}" :
    "export MMPROJECT=default; LOGGY_STACKS=1 ./node_modules/brunch/bin/brunch watch --stdin --env #{config[:environment]}",
  source: ".tmp/dist",
  latency: 2


activate :external_pipeline,
  name: :sdk,
  command: build? ?
    "export MMPROJECT=sdk; LOGGY_STACKS=1 ./node_modules/brunch/bin/brunch build --env #{config[:environment]}" :
    "export MMPROJECT=sdk; LOGGY_STACKS=1 ./node_modules/brunch/bin/brunch watch --stdin --env #{config[:environment]}",
  source: ".tmp/dist",
  latency: 2



after_build do |builder|
  # add event after build
  #Ex.: exit 1 unless builder.run 'karma start karma.config.js --single-run'
  #exit 1 unless system 'rm ./build/assets/js/test* &>/dev/null'
end

