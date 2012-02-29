# Include hook code here
require 'user_interface'

config.to_prepare do
  ApplicationController.helper LanguagesHelper

  ActionView::Base.send :include, UserInterface::FlashHelper
  ActionView::Base.send :include, UserInterface::TitleHelper

  if defined?(WillPaginate::ViewHelpers)
    require 'user_interface/helpers/will_paginate_helper'
    ActionView::Base.send :include, UserInterface::WillPaginateHelper
  end
end


