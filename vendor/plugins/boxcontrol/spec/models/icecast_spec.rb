require 'spec_helper'

describe Icecast do

  it { should validate_numericality_of(:clients, :greater_than => 0, :less_than => 100) }

  it { should validate_presence_of(:source_password) }

  it { should_not be_new_record }

  its(:port) { should == 8000 }

  its(:host) { should == "localhost" }

  describe "#available? " do
    
    it "should be true when valid? and port_respond? " do
      subject.stub :valid? => true, :port_respond? => true
      subject.should be_available
    end

    it "should be false if not valid" do
      subject.stub :valid? => false
      subject.should_not be_available
    end

    it "should be false if port doesn't respond" do
      subject.stub :port_respond? => false
      subject.should_not be_available
    end

  end

  describe "url" do
    
    it "should be http://<host>:<port> by default" do
      subject.stub :host => "host", :port => "port"
      subject.url.should == "http://host:port"
    end

    it "should be http://<specified_host>:<port> with a specified host" do
      subject.stub :port => "port"
      subject.url("specified_host").should == "http://specified_host:port"
    end

  end

  describe "clients" do
    
    it "should be 5 by default" do
      subject.clients.should == 5
    end

  end

  describe "source_password" do
    
    it "should not accept < character" do
      subject.should_not allow_values_for(:source_password, "abc<")
    end

  end

  describe "port_respond? " do

    let(:socket) { mock :close => true }
    
    it "should be false if timeout is reached" do
      subject.should_receive(:timeout).and_raise(Timeout::Error)
      subject.port_respond?.should be_false
    end

    it "should use the specified timeout" do
      subject.should_receive(:timeout).with(100)
      subject.port_respond?(100)
    end

    it "should create a TCPSocket can be created with host and port" do
      TCPSocket.should_receive(:new).with(subject.host, subject.port).and_return(socket)
      subject.port_respond?
    end

    it "should close the created TCPSocket" do
      TCPSocket.stub :new => socket
      socket.should_receive(:close)
      subject.port_respond?
    end

    it "should be false if TCPSocket can't be created" do
      TCPSocket.should_receive(:new).and_raise(SocketError)
      subject.port_respond?.should be_false      
    end

    it "should true if TCPSocket can be created" do
      TCPSocket.stub :new => socket
      subject.port_respond?.should be_true      
    end

  end

end
