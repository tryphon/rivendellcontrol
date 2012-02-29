require 'rake/tasklib'
require 'tempfile'

module UserInterface::Tasks
  class Install
    attr_accessor :logo
    
    def initialize(options = {})
      options.each { |k,v| send("#{k}=", v) }
      yield self if block_given?

      namespace :user_interface do
        desc "Install user_interface static files"
        task(:install) do
          cp_r plugin_file("images/ui"), "#{Rails.public_path}/images"
          cp plugin_file("images/#{logo}.png"), "#{Rails.public_path}/images"
          cp plugin_file("stylesheets/reset.css"), "public/stylesheets"
        end
      end
    end

    def plugin_file(name)
      "#{File.dirname(__FILE__)}/../../../#{name}"
    end
    
  end
end

