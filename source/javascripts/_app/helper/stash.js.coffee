#NAME
#  Stash Helper
#
#DESCRIPTION
#  This helper provide a simple way to stash to a data-model element
#
#SINOPSYS
# 
#  # setting stash
#  stash 'user_email', 'joe@doe.com'
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra


# message helper
@stash = (key, value, options={}) ->
  $el = options.root || document.body
  $list = $($el).find("[data-model=#{key}]")
  if $list and $list.length > 0
    $list.html(value || "")

  return $el if options.root

