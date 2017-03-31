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
  input: 'source/javascripts',
  output: 'spec/public',
  all_on_start: true,
  patterns: [%r{^source/javascripts/(.+\.js\.(?:coffee|coffee\.md|litcoffee|js))$}]
  #patterns: [%r{^source/javascripts/.+/(.+\.(?:coffee|coffee\.md|litcoffee|js))$}]
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
  all_on_start: true,
  patterns: [%r{^spec/coffeescripts/(.+\.(?:coffee|coffee\.md|litcoffee|js))$}]
  #patterns: [%r{^spec/coffeescripts/(.+\.js\.(?:coffee|coffee\.md|litcoffee|js))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end


###
# Reload test page
###
guard 'livereload' do
  watch %r{^spec/coffeescripts/(.+\.(?:coffee|coffee\.md|litcoffee|js))$}
  watch %r{^source/javascripts/(.+\.js\.(?:coffee|coffee\.md|litcoffee|js))$}
end
