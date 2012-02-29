module UserInterface::WillPaginateHelper
  include WillPaginate::ViewHelpers 
 
  def will_paginate_with_i18n(collection = nil, options = {}) 
    will_paginate_without_i18n collection, options_with_i18n(options)
  end 

  alias_method_chain :will_paginate, :i18n 

  def options_with_i18n(options)
    options.merge :previous_label => I18n.t("will_paginate.previous", :default => "Previous"), :next_label => I18n.t("will_paginate.next", :default => "Next")
  end
end
