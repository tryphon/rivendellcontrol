class Ssh < ActiveForm::Base
  include PuppetConfigurable

  attr_accessor :authorized_keys

  validates_format_of :authorized_keys, :with => %r{\A[a-zA-Z0-9/=@ \r\n+-]+\Z}

  def key_count
    authorized_keys.present? ? authorized_keys.split("\n").size : 0
  end

  def new_record?
    false
  end

end
