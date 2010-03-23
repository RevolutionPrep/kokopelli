require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::SCO::Base do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::SCO::Base object" do
      @sco = Kokopelli::SCO::Base.new(
        :id => "12345",
        :tree_id => "54321",
        :type => "content",
        :domain => "www.test.com",
        :source_id => "67890",
        :folder_id => "98765",
        :display_seq => "0",
        :is_folder => true,
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "content",
        :created_at => Time.parse("2010-02-02T18:03:38.580-08:00"),
        :updated_at => Time.parse("2010-02-04T18:03:38.580-08:00"),
        :starts_at => Time.parse("2010-02-04T18:03:38.580-08:00"),
        :ends_at => Time.parse("2010-02-04T18:03:38.580-08:00"),
        :description => "this is some description"
      )
      @sco.class.should eql(Kokopelli::SCO::Base)
      @sco.id.should eql("12345")
      @sco.tree_id.should eql("54321")
      @sco.type.should eql("content")
      @sco.domain.should eql("www.test.com")
      @sco.source_id.should eql("67890")
      @sco.folder_id.should eql("98765")
      @sco.display_seq.should eql("0")
      @sco.is_folder.should be_true
      @sco.name.should eql("SCO")
      @sco.url_path.should eql("sco_path")
      @sco.icon.should eql("content")
      @sco.created_at.should eql(Time.parse("2010-02-02T18:03:38.580-08:00"))
      @sco.updated_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @sco.starts_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @sco.ends_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @sco.description.should eql("this is some description")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      @sco = Kokopelli::SCO::Base.new(
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
      @sco.save
      @sco.id.should_not be_nil
      @sco.type.should eql("meeting")
      @sco.source_id.should eql("1030182073")
      @sco.folder_id.should eql("1030182069")
      @sco.display_seq.should_not be_nil
      @sco.is_folder.should be_false
      @sco.name.should eql("SCO")
      @sco.url_path.should eql("sco_path")
      @sco.icon.should eql("meeting")
      @sco.created_at.should_not be_nil
      @sco.updated_at.should_not be_nil
      @sco.starts_at.should eql(Time.parse("2010-02-04T18:03:38-08:00"))
      @sco.ends_at.should eql(Time.parse("2010-02-04T19:03:38-08:00"))
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("sco-update&sco-id=1036115664&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=SCO%20New")
      @sco = Kokopelli::SCO::Base.new(
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
      @sco.save
      @sco.update_attributes(
        :name => "SCO New",
        :url_path => "sco_2_path",
        :starts_at => Time.parse("2010-02-04T20:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T21:03:38-08:00"),
        :description => "this is some new description"
      )
      @sco.id.should_not be_nil
      @sco.type.should eql("meeting")
      @sco.source_id.should eql("1030182073")
      @sco.folder_id.should eql("1030182069")
      @sco.display_seq.should_not be_nil
      @sco.is_folder.should be_false
      @sco.name.should eql("SCO New")
      @sco.url_path.should eql("sco_2_path")
      @sco.icon.should eql("meeting")
      @sco.created_at.should_not be_nil
      @sco.updated_at.should_not be_nil
      @sco.starts_at.should eql(Time.parse("2010-02-04T20:03:38-08:00"))
      @sco.ends_at.should eql(Time.parse("2010-02-04T21:03:38-08:00"))
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("sco-delete&sco-id=1036115664")
      @sco = Kokopelli::SCO::Base.new(
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
      @sco.save
      @sco.destroy.should be_true
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::SCO::Base.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Base without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053", :empty)
      @scos = Kokopelli::SCO::Base.find(:all)
      @scos.should be_empty
    end

    it "should return an array of Kokopelli::SCO::Base objects if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053")
      @scos = Kokopelli::SCO::Base.find(:all)
      @scos.class.should eql(Array)
      @scos.should_not be_empty
      @scos.each do |sco|
        sco.class.should eql(Kokopelli::SCO::Base)
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053")
      Kokopelli::SCO::Base.all.should eql(Kokopelli::SCO::Base.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053", :empty)
      Kokopelli::SCO::Base.find(:first).should eql(nil)
    end

    it "should return a single Kokopelli::SCO::Base object is any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053")
      @sco = Kokopelli::SCO::Base.find(:first)
      @sco.class.should eql(Kokopelli::SCO::Base)
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182076")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182068")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182067")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182042")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182044")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182043")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182047")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182048")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182049")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182050")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182054")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182052")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182053")
      Kokopelli::SCO::Base.first.should eql(Kokopelli::SCO::Base.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return nil if no result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=12345")
      lambda{ Kokopelli::SCO::Base.find("12345") }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=sco-info&sco-id=12345&session=na1breezaspo5qded43ka7fh)")
    end

    it "should return a single Kokopelli::SCO::Base object if nay results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=1030726615")
      @sco = Kokopelli::SCO::Base.find("1030726615")
      @sco.class.should eql(Kokopelli::SCO::Base)
      @sco.id.should eql("1030726615")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::SCO::Base.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Base with this ID")
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