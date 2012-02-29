$: << "#{File.dirname(__FILE__)}/lib"
require 'rubygems'
require 'user_interface/tasks'

UserInterface::Tasks::Css.new :stylesheet, 
  :color => ENV['COLOR'], :logo => ENV['LOGO'], :watch => ENV['WATCH']

begin
  require 'deadweight'

  Deadweight::RakeTask.new do |dw|
    dw.stylesheets = %w( stylesheets/tryphon.css )
    dw.pages = %w( index.html )
    dw.root = ""
    dw.log_file = "/dev/null"
  end
rescue LoadError
  puts "Warning: deadweight gem is missing"
end

namespace :gems do
  desc "Install required gems"
  task :install do 
    sh "gem install less deadweight -s http://gemcutter.org"
  end
end

task :default => :stylesheet

require 'rake'
require 'spec/rake/spectask'

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end
