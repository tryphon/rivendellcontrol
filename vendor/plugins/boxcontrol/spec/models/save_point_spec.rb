require 'spec_helper'

describe SavePoint do

  before(:each) do
    @save_point = SavePoint.new
  end

  it "should use '/bin/true' as default save command" do
    @save_point.save_command.should == '/bin/true'
  end

  it "should return true if save command is successfully modified" do
    @save_point.save.should be_true
  end

  it "should return false if save command isn't successful" do
    @save_point.stub!(:save_command).and_return("/bin/false")
    @save_point.save.should be_false
  end

  it "should execute the save command when saves" do
    @save_point.stub!(:save_command).and_return("dummy")
    @save_point.should_receive(:system).with("dummy")
    @save_point.save
  end

end
