class ReleasesController < InheritedResources::Base
  unloadable

  before_filter :check_releases, :only => :index

  actions :index, :show
  respond_to :html, :xml, :json

  def index
    index! do |format|
      format.html do
        @current = Release.current
        @latest = Release.latest
      end
    end
  end

  def download
    resource.start_download
    redirect_to releases_path
  end

  def install
    resource.install
    redirect_to releases_path
  end

  def description
    render resource
  end

  protected

  def resource_with_name
    case params[:id]
    when "current"
      @release ||= Release.current
    when "latest"
      @release ||= Release.latest
    else
      resource_without_name
    end
  end
  alias_method_chain :resource, :name

  def check_releases
    Release.check
  end

end
