require 'rake/tasklib'
require 'tempfile'

module UserInterface::Tasks
  class Css
    attr_accessor :color, :logo, :watch
    
    def initialize(name = :stylesheet, options = {})
      options = { 
        :color => "#a559e4",
        :logo => 'bonnes-ondes'
      }.update(options.delete_if { |k,v| v.nil? })
      
      options.each { |k,v| send("#{k}=", v) }
      yield self if block_given?

      namespace :user_interface do
        desc "Build tryphon.css from less definition"
        task(name) do
          Tempfile.open("tryphon-css") do |f|
            f.puts "@color: #{color};"
            f.puts "@logo_url: #{logo_url};"
            f.puts IO.read(less_file)
            f.close
            
            sh "lessc #{f.path} #{stylesheet_file}"
          end
        end
      end
    end
    
    def logo_url
      "url(\"../images/#{logo}.png\")"
    end

    def less_file
      plugin_file "tryphon.less"
    end

    def plugin_file(name)
      "#{File.dirname(__FILE__)}/../../../#{name}"
    end

    def stylesheet_file
      if defined?(Rails)
        "#{Rails.public_path}/stylesheets/tryphon.css"
      else
        plugin_file "stylesheets/tryphon.css"
      end
    end
    
  end
end

