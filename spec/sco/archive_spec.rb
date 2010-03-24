require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::SCO::Archive do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::SCO::Archive.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Archive without ID")
    end

  end

  describe ".find(:id)" do

    it "should return nil if no result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=12345")
      lambda{ Kokopelli::SCO::Archive.find("12345") }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=sco-info&sco-id=12345&session=na1breezaspo5qded43ka7fh)")
    end

    it "should return a single Kokopelli::SCO::Archive object if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=1030726615")
      @sco = Kokopelli::SCO::Archive.find("1030726615")
      @sco.class.should eql(Kokopelli::SCO::Archive)
      @sco.id.should eql("1030726615")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::SCO::Archive.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Archive with this ID")
    end

  end

  describe ".reload!" do
  
    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
        FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      @first = Kokopelli::SCO::Base.new(
        :type => "meeting",
        :source_id => "1030182073",
        :folder_id => "1030182069",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @first.save
      @second = @first.reload!
      @first.should eql(@second)
      @first.type.should eql(@second.type)
      @first.source_id.should eql(@second.source_id)
      @first.folder_id.should eql(@second.folder_id)
      @first.name.should eql(@second.name)
      @first.url_path.should eql(@second.url_path)
      @first.icon.should eql(@second.icon)
      @first.starts_at.should eql(@second.starts_at)
      @first.ends_at.should eql(@second.ends_at)
      @first.description.should eql(@second.description)
    end

  end

  describe ".valid?" do

    it "should be valid" do
      @sco = Kokopelli::SCO::Base.new
      @sco.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record" do
      @sco = Kokopelli::SCO::Base.new
      @sco.should be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @sco = Kokopelli::SCO::Base.new
      @clone = @sco
      @sco.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @sco = Kokopelli::SCO::Base.new(:id => "1")
      @clone = Kokopelli::SCO::Base.new(:id => "2")
      @sco.eql?(@clone).should be_false
    end

  end

end