class AlsaInput < Input

  attr_accessor :gain

  validates_presence_of :gain
  validates_numericality_of :gain, :greater_than_or_equal_to => -20, :less_than_or_equal_to => 20 

  def after_initialize
    self.gain ||= -3
  end

end
