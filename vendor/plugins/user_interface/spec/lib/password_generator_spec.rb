require 'spec_helper'

describe PasswordGenerator do
  
  context "by default" do

    let(:default_character_set) { "default_character_set" }

    before(:each) do
      subject.stub :default_character_set => default_character_set
    end

    its(:length) { should == 10 }
    its(:character_set) { should == default_character_set }

  end

  describe ".default_character_set" do

    let(:alpha_numerical_characters) {
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars.to_a
    }
    
    it "should include all alpha numerical characters" do
      subject.default_character_set.should == alpha_numerical_characters
    end

  end

  describe "#random_character" do

    it "should return a random character from #character_set" do
      subject.character_set.stub :random_element => 'random'
      subject.random_character.should == 'random'
    end
    
  end

  describe "#characters" do
    
    it "should return length random characters" do
      subject.stub :length => 3, :random_character => "a"
      subject.characters.should == ['a'] * 3
    end

  end

  describe "#create" do
    
    it "should join characters" do
      subject.stub :characters => ['a','b','c']
      subject.create.should == "abc"
    end

  end

end
