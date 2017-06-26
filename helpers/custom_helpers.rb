# requires
require 'helpers/tag_helpers.rb'

# Middleman Custom Helpers
module CustomHelpers
  include CustomTagHelpers

  # set current active link
  def current_link(ctrl, act = nil, css = 'link-light')
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
    page_application :controller, type
  end

  # shortcut that return module name
  def page_module(type = nil)
    page_application :module, type
  end

  def page_application(name = :controller, type = nil)
    source = current_page.data[name]
    if type == 'attr' and source
      source = "data-#{name}=\"#{source}\""
    end

    source
  end

  # shortcut that return action name
  def page_action
    current_page.data.action || ''
  end

  def page_data
    data.pages
  end

end
