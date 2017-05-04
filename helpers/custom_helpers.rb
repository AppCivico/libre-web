# requires
require 'helpers/tag_helpers.rb'

# Middleman Custom Helpers
module CustomHelpers
  include CustomTagHelpers

  # set current active link
  def current_link(ctrl, act=nil, css='link-light')
    if ctrl and not act
      current_page.data.controller == ctrl ? css : ''
    elsif ctrl and act
      current_page.data.controller == ctrl and current_page.data.action == act ? css : ''
    else
      ""
    end
  end

  # shortcut that return controller name
  def page_controller(type = nil)
    if type == 'attr'
      current_page.data.controller ?  "data-controller=\"#{current_page.data.controller}\"" : ""
    else
      current_page.data.controller
    end
  end

  # shortcut that return module name
  def page_module(type = nil)
    if type == 'attr'
      current_page.data.module ?  "data-module=\"#{current_page.data.module}\"" : ""
    else
      current_page.data.module
    end
  end

  # shortcut that return action name
  def page_action
    current_page.data.action || ''
  end

  def page_data
    data.pages
  end

end
