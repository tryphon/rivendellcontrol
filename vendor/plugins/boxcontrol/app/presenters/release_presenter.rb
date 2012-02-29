class ReleasePresenter < Presenter

  def initialize(release)
    @release = release
  end

  def human_status
    I18n.translate("releases.status.#{@release.status}", :default => default_status)
  end

  def default_status
    @release.status.to_s.humanize
  end

  def download_progress
    if @release.status.download_pending? and @release.download_size and @release.download_size > 0 and @release.url_size
      "#{helpers.number_to_human_size(@release.download_size)}/#{helpers.number_to_human_size(@release.url_size)}"
    end
  end

end
