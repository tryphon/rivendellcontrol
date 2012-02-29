require 'spec_helper'

describe AlsaInput do

  it { should validate_presence_of(:gain) }

  it { should validate_numericality_of(:gain, :greater_than_or_equal_to => -20, :less_than_or_equal_to => 20) }

  context "by default" do
    its(:gain) { should == -3 }
  end

end
