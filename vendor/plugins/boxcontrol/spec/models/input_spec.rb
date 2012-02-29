require 'spec_helper'

describe Input do

  it { should_not be_new_record }

  describe ".has_tuner?" do

    it "should test if /dev/radio0 device exists" do
      File.should_receive(:exists?).with("/dev/radio0").and_return(true)
      Input.should have_tuner
    end
    
  end

  describe ".detected_current_class" do
    
    it "should be TunerInput when a tuner is present" do
      Input.should_receive(:has_tuner?).and_return(true)
      Input.detect_current_class.should == TunerInput
    end

    it "should be AlsaInput when no tuner is present" do
      Input.should_receive(:has_tuner?).and_return(false)
      Input.detect_current_class.should == AlsaInput
    end

  end

  describe ".current_class" do

    after(:each) do
      Input.current_class = nil
    end

    it "should use a specified current class" do
      Input.current_class = TunerInput
      Input.should_not_receive(:detect_current_class)
      Input.current_class.should == TunerInput
    end

    context "when no current class is defined" do

      before(:each) do
        Input.current_class = nil
      end

      let(:detected_current_class) { stub }

      it "should use the detected implementation" do
        Input.should_receive(:detect_current_class).and_return(detected_current_class)
        Input.current_class.should == detected_current_class
      end
                                                 
    end

  end

  describe ".current" do

    let(:loaded_input) { stub }
    let(:current_class) { stub :load => loaded_input }
    
    it "should load the current Input class" do
      Input.should_receive(:current_class).and_return(current_class)
      Input.current.should == loaded_input
    end

  end

end
