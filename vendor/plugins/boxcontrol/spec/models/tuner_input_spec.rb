require 'spec_helper'

describe TunerInput do

  it { should validate_presence_of(:frequency) }
  it { should validate_presence_of(:volume) }

  it { should validate_numericality_of(:frequency, :greater_than_or_equal_to => 87.5, :less_than_or_equal_to => 108) }
  it { should validate_numericality_of(:volume, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100) }

  context "by default" do
    its(:frequency) { should == 107.7 }
    its(:volume) { should == 100 }
  end

end
