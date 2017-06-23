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


module Brunch

  def self.command(opts = {})
    opts = prepare_params(opts)
    "export BrunchApp=#{opts[:project]}; LOGGY_STACKS=#{opts[:loggy]} #{opts[:brunch_path]} #{opts[:command]} --env #{opts[:env]}"
  end

  def self.build(opts = {})
    opts[:command] = 'build'
    command(opts)
  end

  def self.watch(opts = {})
    opts[:command] = 'watch --stdin'
    command(opts)
  end

  private

  def self.prepare_params(opts = {})
    opts[:command] ||=  'build'
    opts[:project] ||=  'default'
    opts[:loggy] ||= 1
    opts[:env] ||= 'development'
    opts[:brunch_path] ||= './node_modules/brunch/bin/brunch'
    opts
  end
end


# external asset pipeline
activate :external_pipeline,
  name: :webapp,
  command: build? ?
    Brunch.build(project: 'default', env: config[:environment]) :
    Brunch.watch(project: 'default', env: config[:environment]),
  source: ".tmp/dist",
  latency: 2

activate :external_pipeline,
  name: :sdk,
  command: build? ?
    Brunch.build(project: 'sdk', env: config[:environment]) :
    Brunch.watch(project: 'sdk', env: config[:environment]),
  source: ".tmp/dist",
  latency: 2



after_build do |builder|
  # add event after build
  #Ex.: exit 1 unless builder.run 'karma start karma.config.js --single-run'
  #exit 1 unless system 'rm ./build/assets/js/test* &>/dev/null'
end

