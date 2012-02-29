module UserInterface
  module UserSessionManagement

    def self.included(base)
      base.class_eval do
        helper_method :user_session
      end
    end

    protected

    def user_session(defaults = {})
      @user_session ||= UserSession.new session, :language => accepted_language
    end

    def accepted_language
      if http_accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
        http_accept_language.scan(/^[a-z]{2}/).first
      end
    end

  end
end
