namespace :boxcontrol do
  desc "Install BoxControl static files"
  task :install do
    cp plugin_files("javascripts/*.js"), "#{Rails.public_path}/javascripts/"
    cp plugin_files("stylesheets/*.css"), "#{Rails.public_path}/stylesheets/"
  end

  def plugin_files(name)
    Dir["#{File.dirname(__FILE__)}/../public/#{name}"]
  end
end
