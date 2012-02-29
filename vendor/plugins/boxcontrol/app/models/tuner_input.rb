class TunerInput < Input

  attr_accessor :frequency, :volume

  validates_presence_of :frequency, :volume
  validates_numericality_of :frequency, :greater_than_or_equal_to => 87.5, :less_than_or_equal_to => 108
  validates_numericality_of :volume, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100

  def after_initialize
    self.frequency ||= 107.7
    self.volume ||= 100
  end

end
