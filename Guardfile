# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"


###
# Application files
###
coffeescript_options = {
  input: './source/javascripts',
  output: 'spec/public',
  patterns: [%r{^source/javascripts/.+/(.+\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end

###
# Test files
###
coffeescript_options = {
  input: 'spec/coffeescripts',
  output: 'spec/javascripts',
  patterns: [%r{^spec/coffeescripts/(.+\.js\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end


guard 'livereload' do
  extensions = {
    js: :js,
    coffee: :js,
    html: :html,
  }

  rails_view_exts = %w(erb haml slim)

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{spec/public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/source/javascripts/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{source/.+\.(#{rails_view_exts * '|'})$})
  #watch(%r{app/helpers/.+\.rb})
  #watch(%r{config/locales/.+\.yml})
end
