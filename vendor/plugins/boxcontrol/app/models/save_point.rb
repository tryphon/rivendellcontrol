require 'fileutils'

class SavePoint < ActiveForm::Base

  @@save_command = "/bin/true"
  cattr_accessor :save_command

  def save
    system save_command
  end

end
