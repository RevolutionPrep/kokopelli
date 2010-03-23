require File.dirname(__FILE__) + '/spec_helper'

describe Kokopelli do

  describe ".admin" do

    before(:each) do
      FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
      if KOKOPELLI[:use_fake_web]
        FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      end
    end
    
    after(:each) do
      FakeWeb.clean_registry
    end

    it "should always return a logged in admin user object" do
      @admin = Kokopelli.admin
      @admin.class.should eql(Kokopelli::Principal::Admin)
      @admin.session.should eql("na1breezaspo5qded43ka7fh")
    end

  end
end