module UserInterface::LocaleManagement

  def self.included(base)
    base.class_eval do
      before_filter :change_locale
    end
  end

  private

  def change_locale
    if params[:lang]
      logger.debug "Overrides session language with param lang : #{params[:lang]}"
      user_session.language = params[:lang] 
    end
    I18n.locale = user_session.language
  end

end
