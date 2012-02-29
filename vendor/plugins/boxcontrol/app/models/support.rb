require 'ipaddr'
require 'socket'

class Support < ActiveForm::Base
  include PuppetConfigurable

  attr_accessor :boot_check
  attr_accessor :poll_check

  def after_initialize
    self.boot_check ||= '1'
    self.poll_check ||= '1'
  end

  def new_record?
    false
  end

  def presenter
    @presenter ||= SupportPresenter.new(self)
  end
end
