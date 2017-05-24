# See docs at http://brunch.readthedocs.org/en/latest/config.html.

# getting configuration by context
context = process.env.MMPROJECT or 'default'
console.log "### Running Project '#{context}' ###"

# choose project compilation
brunch_config = switch context
  # default web application source
  when 'default' then require('./config/brunch/default.coffee')
  # sdk application source
  when 'sdk' then require('./config/brunch/sdk.coffee')
  # default is none
  else (new Object)

# export config and start brunch.io
exports.config = brunch_config
