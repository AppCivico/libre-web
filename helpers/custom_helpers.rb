# Middleman Custom Helpers
module CustomHelpers

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
  def get_controller
    current_page.data.controller || ''
  end

  # shortcut that return action name
  def get_action
    current_page.data.action || ''
  end

  def page_data
    data.pages
  end
end
