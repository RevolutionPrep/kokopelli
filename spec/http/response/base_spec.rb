require File.dirname(__FILE__) + '/../../spec_helper'

module KokopelliResponseHelpers
  class Payload; end
end

describe Kokopelli::HTTP::Response::Base do

  it "should retain a reason if set as an attribute" do
    @response = Kokopelli::HTTP::Response::Base.new(:reason => "Testing")
    @response.class.should eql(Kokopelli::HTTP::Response::Base)
    @response.reason.should eql("Testing")
  end

  it "should retain a payload if set as an attribute" do
    @response = Kokopelli::HTTP::Response::Base.new(:payload => KokopelliResponseHelpers::Payload.new)
    @response.class.should eql(Kokopelli::HTTP::Response::Base)
    @response.payload.class.should eql(KokopelliResponseHelpers::Payload)
  end

  it "should retain a request if set as an attribute" do
    FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
    @request = Kokopelli::HTTP::Request::Base.new("http://www.example.com/success")
    @response = Kokopelli::HTTP::Response::Base.new(:request => @request)
    @response.request.class.should eql(Kokopelli::HTTP::Request::Base)
    @response.request.url.should match(/http:\/\/www.example.com\/success/)
    @response.reason.should match(/http:\/\/www.example.com\/success/)
  end

end