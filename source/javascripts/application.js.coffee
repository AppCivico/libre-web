##########################
# App requires
##########################
#=require "_polyfills"

#=require "_app/bolt"

# require lib
#=require_directory "./_app/lib/"

# require helpers
#=require_directory "./_app/helper/"

# require resources
#=require "_app/resource/base"
#=require_directory "./_app/resource/"

## require controller
#=require "_app/controller/base"
#=require_directory "./_app/controller/"

#=require_tree ./_app


# App SPE (Single Point Entry)
# -----------------------------
# Init application by calling Saveh class and init
# method inherited of Application class.
Turbolinks.start()

# loading application under turbolinks
document.addEventListener "turbolinks:load", ->
  try
    # changes to show progress bar
    #Turbolinks.BrowserAdapter.prototype.showProgressBarAfterDelay = ->
    #  @progressBarTimeout = setTimeout(@showProgressBar, 0)

    # loading components
    Application.init()
  catch e
    console.error(e.message)
