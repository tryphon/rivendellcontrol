module ReleasesHelper

  def link_to_description(release)
    link_to translate("releases.actions.description"), release.description_url, :class => "view", :target => "_blank" if release.description_url
  end

  def link_to_action(release)
    if release.status.downloaded?
      link_to t("releases.actions.install_and_reboot"), install_release_path(release), :class => "install"
    elsif release.status.download_pending?
      link_to t("releases.actions.download_pending"), releases_path, :class => "download-pending release", :"data-release-id" => release.id
    else
      link_to t("releases.actions.download"), download_release_path(release), :class => "download"
    end
  end

end
