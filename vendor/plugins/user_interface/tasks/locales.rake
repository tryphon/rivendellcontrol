namespace :locales do

  def locales
    %w{fr}
  end

  namespace :rails do

    def get_locale(url)
      sh "wget -P #{rails_locales_dir} --timestamping #{url}"
    end

    def rails_locales_dir
      "#{Rails.root}/config/locales"
    end

    desc "Retrieve rails-18n files from github"
    task :update do
      mkdir rails_locales_dir unless File.exist? rails_locales_dir

      locales.each do |locale|
        get_locale "http://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/#{locale}.yml"
      end
    end  
  end

end
