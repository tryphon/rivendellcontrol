class Input < ActiveForm::Base
  include PuppetConfigurable

  def self.has_tuner?
    File.exists?("/dev/radio0")
  end

  @@current_class = nil
  cattr_writer :current_class
  def self.current_class
    @@current_class ||= detect_current_class
  end

  def self.detect_current_class
    has_tuner? ? TunerInput : AlsaInput
  end

  def self.current
    current_class.load
  end

  def new_record?
    false
  end

  def presenter
    @presenter ||= InputPresenter.new(self)
  end

end
