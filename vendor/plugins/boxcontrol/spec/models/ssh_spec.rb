require 'spec_helper'

describe Ssh do

  describe "#authorized_keys" do

    it "should accept ssh keys" do
      subject.authorized_keys = "ssh-dss AAyUp/o1c-7+bJUP9== user@host\nssh-dss AAyUp/o1c-7+bJUP9== user@host"
      subject.should be_valid
    end

    it "should not accept every character" do
      subject.authorized_keys = 'dummy with " or *'
      subject.should_not be_valid
    end
    
  end

end
