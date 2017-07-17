###
# PostMessage mixin class
# @author
###
module.exports = class PostMessage

  # post message
  postMessage: (data = {}, origin = "*") ->
    json = JSON.stringify data
    w = window.parent || window
    w.postMessage json, origin


