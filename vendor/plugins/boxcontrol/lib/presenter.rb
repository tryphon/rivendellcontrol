class Presenter

  def helpers
    master_helper_module = [ActionView::Helpers::AssetTagHelper, ActionView::Helpers::UrlHelper, ActionView::Helpers::NumberHelper]
    @helper_proxy ||= HelperProxy.new(self, master_helper_module)
  end

  class HelperProxy < ActionView::Base

    def initialize(controller, master_helper_module)
      # required by url_for for example
      @controller = controller
      Array(master_helper_module).each { |m| extend m }
    end
    
  end

end

