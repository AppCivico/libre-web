#NAME
#  Redirect Helper
#
#DESCRIPTION
#  This helper provide a simple wrapper for document.location
#  attribute making redirect to other pages.
#
#SINOPSYS
#
#  # string interpolation
#  redirect_to "/user/#{id}"
#
#  # inside your app
#  redirect_to "/account/signin"
#
#  # redirect to outside page
#  redirect_to "http://google.com/"
#
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra

# redirect helper
try
  @redirect_to = (url) ->
    document.location = url

catch e
  console.error e.message
