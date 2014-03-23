if defined?(Rails)
  Box.logger = Rails.logger
else
  require 'logger'
  Box.logger = Logger.new("log/box.log")
end

# unless Box.executable.start_with?("bundle exec")
#   Box.executable = "bundle exec #{Box.executable}"
# end

# puts Box.executable

Box::Release.latest_url = "http://dev.tryphon.priv/dist/rivendellboxes/latest.yml"
Box::Release.current_url = "public/current.yml"
Box::Release.install_command = "/bin/true"

# Use this script to initialize Box commands executed in background
Box.start_default_options = { :config => __FILE__ }

Box::PuppetConfiguration.configuration_file = "tmp/config.pp"
