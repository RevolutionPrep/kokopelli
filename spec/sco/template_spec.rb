require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::SCO::Template do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::SCO::Template object" do
      @template = Kokopelli::SCO::Template.new(
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
      @template.class.should eql(Kokopelli::SCO::Template)
      @template.id.should eql("12345")
      @template.tree_id.should eql("54321")
      @template.type.should eql("content")
      @template.domain.should eql("www.test.com")
      @template.source_id.should eql("67890")
      @template.folder_id.should eql("98765")
      @template.display_seq.should eql("0")
      @template.is_folder.should be_true
      @template.name.should eql("SCO")
      @template.url_path.should eql("sco_path")
      @template.icon.should eql("content")
      @template.created_at.should eql(Time.parse("2010-02-02T18:03:38.580-08:00"))
      @template.updated_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @template.starts_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @template.ends_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @template.description.should eql("this is some description")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied")
      @template = Kokopelli::SCO::Template.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "TEMPLATE",
        :url_path => "sco_template_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @template.save
      @template.id.should_not be_nil
      @template.type.should eql("meeting")
      @template.source_id.should eql("1030182073")
      @template.folder_id.should eql("1030182072")
      @template.display_seq.should_not be_nil
      @template.is_folder.should be_false
      @template.name.should eql("TEMPLATE")
      @template.url_path.should eql("sco_template_path")
      @template.icon.should eql("meeting")
      @template.created_at.should_not be_nil
      @template.updated_at.should_not be_nil
      @template.starts_at.should eql(Time.parse("2010-02-04T18:03:38-08:00"))
      @template.ends_at.should eql(Time.parse("2010-02-04T19:03:38-08:00"))
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path")
      FakeWeb::Mapping.build("sco-update&sco-id=1037064220&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=TEMPLATE%20New")
      FakeWeb::Mapping.build("permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied")
      @template = Kokopelli::SCO::Template.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "TEMPLATE",
      :url_path => "sco_template_path",
      :icon => "meeting",
      :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
      :description => "this is some description"
      )
      @template.save
      @template.update_attributes(
      :name => "TEMPLATE New",
      :url_path => "sco_template_2_path",
      :starts_at => Time.parse("2010-02-04T20:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T21:03:38-08:00"),
      :description => "this is some new description"
      )
      @template.id.should_not be_nil
      @template.type.should eql("meeting")
      @template.source_id.should eql("1030182073")
      @template.folder_id.should eql("1030182072")
      @template.display_seq.should_not be_nil
      @template.is_folder.should be_false
      @template.name.should eql("TEMPLATE New")
      @template.url_path.should eql("sco_template_2_path")
      @template.icon.should eql("meeting")
      @template.created_at.should_not be_nil
      @template.updated_at.should_not be_nil
      @template.starts_at.should eql(Time.parse("2010-02-04T20:03:38-08:00"))
      @template.ends_at.should eql(Time.parse("2010-02-04T21:03:38-08:00"))
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-delete&sco-id=1037064220")
      @template = Kokopelli::SCO::Template.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "TEMPLATE",
      :url_path => "sco_template_path",
      :icon => "meeting",
      :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
      :description => "this is some description"
      )
      @template.save
      @template.destroy.should be_true
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::SCO::Template.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Template without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070", :empty)
      @templates = Kokopelli::SCO::Template.find(:all)
      @templates.should be_empty
    end

    it "should return an array of Kokopelli::SCO::Template objects if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      @templates = Kokopelli::SCO::Template.find(:all)
      @templates.class.should eql(Array)
      @templates.should_not be_empty
      @templates.each do |template|
        template.class.should eql(Kokopelli::SCO::Template)
        template.type.should eql("meeting")
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      Kokopelli::SCO::Template.all.should eql(Kokopelli::SCO::Template.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070", :empty)
      Kokopelli::SCO::Template.find(:first).should eql(nil)
    end

    it "should return a single Kokopelli::SCO::Template object is any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      @template = Kokopelli::SCO::Template.find(:first)
      @template.class.should eql(Kokopelli::SCO::Template)
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182072")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182070")
      Kokopelli::SCO::Template.first.should eql(Kokopelli::SCO::Template.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return nil if no result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=12345")
      lambda{ Kokopelli::SCO::Template.find("12345") }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=sco-info&sco-id=12345&session=na1breezaspo5qded43ka7fh)")
    end

    it "should return a single Kokopelli::SCO::Template object if nay results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=1030726615")
      @template = Kokopelli::SCO::Template.find("1030726615")
      @template.class.should eql(Kokopelli::SCO::Template)
      @template.id.should eql("1030726615")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::SCO::Template.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Template with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182072&name=TEMPLATE&source-sco-id=1030182073&type=meeting&url-path=sco_template_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1037064220&principal-id=public-access&permission-id=denied")
      @first = Kokopelli::SCO::Template.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "TEMPLATE",
      :url_path => "sco_template_path",
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
      @template = Kokopelli::SCO::Template.new
      @template.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record" do
      @template = Kokopelli::SCO::Template.new
      @template.should be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @template = Kokopelli::SCO::Template.new
      @clone = @template
      @template.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @template = Kokopelli::SCO::Template.new(:id => "1")
      @clone = Kokopelli::SCO::Template.new(:id => "2")
      @template.eql?(@clone).should be_false
    end

  end

end