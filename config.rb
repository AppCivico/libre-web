activate :sprockets
activate :directory_indexes


page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/index.html', layout: 'default'


# development env
configure :development do
  activate :livereload

  activate :asset_hash do |opts|
    # ignore email headers
    opts.ignore = [/images\/emails\//i, /\.pdf/i]
  end

end


# build env
configure :build do
  activate :asset_hash do |opts|
    opts.ignore = [/images\/emails\//i, /\.pdf/i]
  end

  activate :minify_css
  activate :minify_javascript
end

# production env
configure :production do
  # ... make production tasks
end


after_build do |builder|
  # add event after build
  #Ex.: exit 1 unless builder.run 'karma start karma.config.js --single-run'
end

