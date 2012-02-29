module ErrorTemplate

  def self.included(base)
    base.class_eval do
      rescue_from Exception, :with => :render_error_template
    end if Rails.env.production?
  end

  def render_error_template(e)
    render :template => "/errors/error_500.html", :status => 500, :locals => { :error => e }
  rescue => e
    render :text => "#{e.message} -- #{e.class}<br/>#{e.backtrace.join("<br/>")}"
  end

end
