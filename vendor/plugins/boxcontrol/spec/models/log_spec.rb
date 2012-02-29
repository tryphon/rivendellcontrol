require 'spec_helper'

describe Log do

  let(:lines) { %w{line1 line2} }
  let(:content) { "content" }

  describe ".syslog_file" do
    
    it "should be '/var/log/syslog' by default" do
      subject.syslog_file.should == '/var/log/syslog'
    end

  end

  describe "#read" do
    
    it "should return syslog_file content" do
      IO.should_receive(:read).with(subject.syslog_file).and_return(content)
      subject.read.should == content
    end

  end

  describe "#readlines" do

    it "should return syslog_file lines" do
      IO.should_receive(:readlines).with(subject.syslog_file).and_return(lines)
      subject.readlines.should == lines
    end
    
  end

  describe "filtered_lines" do

    before(:each) do
      subject.stub :readlines => lines
    end
    
    context "when filter is blank" do

      before(:each) do
        subject.filter = ""
      end
      
      it "should return read lines" do
        subject.filtered_lines.should == subject.readlines
      end
      
    end

    context "when filter is present" do

      it "should return lines with contains filter regexp" do
        subject.filter = "[0-1]"
        subject.filtered_lines.should == %w{line1}
      end
      
    end

  end

  describe "last_lines" do

    let(:a_lot_of_lines) { Array.new(1000) { |n| "line#{n}" } }

    it "should return last filtered lines" do
      subject.stub :filtered_lines => %w{old} + a_lot_of_lines + %w{new}
      subject.last_lines.should include("new")
      subject.last_lines.should_not include("old")
    end

    it "should return 500 filtered lines" do
      subject.stub :filtered_lines => a_lot_of_lines
      subject.last_lines.size.should == 500
    end

    it "should reverse filtered lines" do
      subject.stub :filtered_lines => lines
      subject.last_lines.should == lines.reverse
    end

  end

  describe "compressed" do

    before(:each) do
      subject.stub :read => content
    end
    
    it "should return gzipped content" do
      subject.compressed.should == ActiveSupport::Gzip.compress(content)
    end

  end

  describe ".human_name" do
    
    it "should translate 'activerecord.models.log'" do
      I18n.should_receive(:translate).with('activerecord.models.log').and_return('translation')
      Log.human_name.should == "translation"
    end

  end

end
