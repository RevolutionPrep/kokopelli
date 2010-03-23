require File.dirname(__FILE__) + '/../../spec_helper'

describe Kokopelli::HTTP::Response::Invalid do

  before(:each) do
    FakeWeb.allow_net_connect = false
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  it "should retain a request if set as an attribute" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    FakeWeb::Mapping.build("https://example.com/invalid")
    @request = Kokopelli::HTTP::Request::Base.new("https://example.com/invalid")
    lambda { @request.get! }.should raise_error(Kokopelli::Exception::InternalError, "Invalid Request: url(https://example.com/invalid&session=na1breezaspo5qded43ka7fh) field(action) type(enum) subcode(no-such-item)")
  end

end