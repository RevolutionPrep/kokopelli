require File.dirname(__FILE__) + '/../../spec_helper'

describe Kokopelli::HTTP::Request::Base do

  before(:all) do
    FakeWeb.allow_net_connect = false
    FakeWeb::Mapping.build("https://example.com/success")
    FakeWeb::Mapping.build("https://example.com/failure")
    FakeWeb::Mapping.build("https://example.com/invalid")
    FakeWeb::Mapping.build("https://example.com/indeterminant")
    FakeWeb::Mapping.build("https://example.com/internal_error")
  end

  after(:all) do
    FakeWeb.clean_registry
  end

  it "should return url attribute if set in instantiation" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/success")
    @request.url.should_not be_nil
    @request.url.should eql("https://example.com/success&session=na1breezaspo5qded43ka7fh")
  end

  it "should raise an exception if no url is given in instantiation" do
    lambda { Kokopelli::HTTP::Request::Base.new }.should raise_error(ArgumentError, "wrong number of arguments (0 for 1)")
  end

  it "should retain attributes after request is completed" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/success")
    @request.get!
    @request.response.should_not be_nil
    @request.response.class.should eql(Net::HTTPOK)
    @request.header.should_not be_nil
    @request.header.class.should eql(Net::HTTPOK)
    @request.xml.should_not be_nil
    @request.xml.class.should eql(Nokogiri::XML::Document)
    @request.state.should_not be_nil
  end

  it "should register success on 'ok'" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/success")
    @request.get!
    @request.should be_success
  end

  it "should register failure on 'no-data" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/failure")
    lambda { @request.get! }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://example.com/failure&session=na1breezaspo5qded43ka7fh)")
    @request.should be_failure
  end

  it "should retain invalid_field attribute after invalid request" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/invalid")
    lambda { @request.get! }.should raise_error(Kokopelli::Exception::InternalError, "Invalid Request: url(https://example.com/invalid&session=na1breezaspo5qded43ka7fh) field(action) type(enum) subcode(no-such-item)")
    @request.invalid_field.should_not be_nil
    @request.invalid_field.should eql("action")
    @request.invalid_type.should_not be_nil
    @request.invalid_type.should eql("enum")
    @request.invalid_subcode.should_not be_nil
    @request.invalid_subcode.should eql("no-such-item")
    @request.should be_invalid
  end

  it "should register indeterminant if no status is returned" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/indeterminant")
    lambda { @request.get! }.should raise_error(Kokopelli::Exception::InternalError, "Indeterminant Request: url(https://example.com/indeterminant&session=na1breezaspo5qded43ka7fh)")
    @request.should be_indeterminant
  end

  it "should register internal-error on 'internal-error'" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/internal_error")
    lambda { @request.get! }.should raise_error(Kokopelli::Exception::InternalError)
    @request.should be_internal_error
  end

end