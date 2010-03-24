require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::SCO::Meeting do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::SCO::Meeting object" do
      @meeting = Kokopelli::SCO::Meeting.new(
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
      @meeting.class.should eql(Kokopelli::SCO::Meeting)
      @meeting.id.should eql("12345")
      @meeting.tree_id.should eql("54321")
      @meeting.type.should eql("content")
      @meeting.domain.should eql("www.test.com")
      @meeting.source_id.should eql("67890")
      @meeting.folder_id.should eql("98765")
      @meeting.display_seq.should eql("0")
      @meeting.is_folder.should be_true
      @meeting.name.should eql("SCO")
      @meeting.url_path.should eql("sco_path")
      @meeting.icon.should eql("content")
      @meeting.created_at.should eql(Time.parse("2010-02-02T18:03:38.580-08:00"))
      @meeting.updated_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @meeting.starts_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @meeting.ends_at.should eql(Time.parse("2010-02-04T18:03:38.580-08:00"))
      @meeting.description.should eql("this is some description")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      @meeting = Kokopelli::SCO::Meeting.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "SCO",
      :url_path => "sco_path",
      :icon => "meeting",
      :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
      :description => "this is some description"
      )
      @meeting.save
      @meeting.id.should_not be_nil
      @meeting.type.should eql("meeting")
      @meeting.source_id.should eql("1030182073")
      @meeting.folder_id.should eql("1030182069")
      @meeting.display_seq.should_not be_nil
      @meeting.is_folder.should be_false
      @meeting.name.should eql("SCO")
      @meeting.url_path.should eql("sco_path")
      @meeting.icon.should eql("meeting")
      @meeting.created_at.should_not be_nil
      @meeting.updated_at.should_not be_nil
      @meeting.starts_at.should eql(Time.parse("2010-02-04T18:03:38-08:00"))
      @meeting.ends_at.should eql(Time.parse("2010-02-04T19:03:38-08:00"))
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("sco-update&sco-id=1036115664&date-begin=2010-02-04T20:03:38-08:00&date-end=2010-02-04T21:03:38-08:00&description=this%20is%20some%20new%20description&name=SCO%20New")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      @meeting = Kokopelli::SCO::Meeting.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "SCO",
      :url_path => "sco_path",
      :icon => "meeting",
      :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
      :description => "this is some description"
      )
      @meeting.save
      @meeting.update_attributes(
      :name => "SCO New",
      :url_path => "sco_2_path",
      :starts_at => Time.parse("2010-02-04T20:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T21:03:38-08:00"),
      :description => "this is some new description"
      )
      @meeting.id.should_not be_nil
      @meeting.type.should eql("meeting")
      @meeting.source_id.should eql("1030182073")
      @meeting.folder_id.should eql("1030182069")
      @meeting.display_seq.should_not be_nil
      @meeting.is_folder.should be_false
      @meeting.name.should eql("SCO New")
      @meeting.url_path.should eql("sco_2_path")
      @meeting.icon.should eql("meeting")
      @meeting.created_at.should_not be_nil
      @meeting.updated_at.should_not be_nil
      @meeting.starts_at.should eql(Time.parse("2010-02-04T20:03:38-08:00"))
      @meeting.ends_at.should eql(Time.parse("2010-02-04T21:03:38-08:00"))
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-delete&sco-id=1036115664")
      @meeting = Kokopelli::SCO::Meeting.new(
      :type => "meeting",
      :source_id => "1030182073",
      :name => "SCO",
      :url_path => "sco_path",
      :icon => "meeting",
      :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
      :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
      :description => "this is some description"
      )
      @meeting.save
      @meeting.destroy.should be_true
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::SCO::Meeting.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Meeting without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045", :empty)
      @meetings = Kokopelli::SCO::Meeting.find(:all)
      @meetings.should be_empty
    end

    it "should return an array of Kokopelli::SCO::Meeting objects if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      @meetings = Kokopelli::SCO::Meeting.find(:all)
      @meetings.class.should eql(Array)
      @meetings.should_not be_empty
      @meetings.each do |meeting|
        meeting.class.should eql(Kokopelli::SCO::Meeting)
        meeting.type.should eql("meeting")
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      Kokopelli::SCO::Meeting.all.should eql(Kokopelli::SCO::Meeting.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046", :empty)
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045", :empty)
      Kokopelli::SCO::Meeting.find(:first).should eql(nil)
    end

    it "should return a single Kokopelli::SCO::Meeting object is any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      @meeting = Kokopelli::SCO::Meeting.find(:first)
      @meeting.class.should eql(Kokopelli::SCO::Meeting)
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182069")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182046")
      FakeWeb::Mapping.build("sco-contents&sco-id=1030182045")
      Kokopelli::SCO::Meeting.first.should eql(Kokopelli::SCO::Meeting.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return nil if no result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=12345")
      lambda{ Kokopelli::SCO::Meeting.find("12345") }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=sco-info&sco-id=12345&session=na1breezaspo5qded43ka7fh)")
    end

    it "should return a single Kokopelli::SCO::Meeting object if nay results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-info&sco-id=1030726615")
      @meeting = Kokopelli::SCO::Meeting.find("1030726615")
      @meeting.class.should eql(Kokopelli::SCO::Meeting)
      @meeting.id.should eql("1030726615")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::SCO::Meeting.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::SCO::Meeting with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      @first = Kokopelli::SCO::Meeting.new(
      :type => "meeting",
      :source_id => "1030182073",
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
      @meeting = Kokopelli::SCO::Meeting.new
      @meeting.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record" do
      @meeting = Kokopelli::SCO::Meeting.new
      @meeting.should be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @meeting = Kokopelli::SCO::Meeting.new
      @clone = @meeting
      @meeting.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @meeting = Kokopelli::SCO::Meeting.new(:id => "1")
      @clone = Kokopelli::SCO::Meeting.new(:id => "2")
      @meeting.eql?(@clone).should be_false
    end

  end

  describe ".authenticate(user,state)" do

    it "should enable a permissions state for the specified user on this SCO" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("principal-list&filter-type=live-admins")
      FakeWeb::Mapping.build("group-membership-update&group-id=1030182057&principal-id=1035814880&is-member=true")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=1035814880&permission-id=host")
      FakeWeb::Mapping.build("permissions-info&acl-id=1036115664&principal-id=1035814880")
      @meeting = Kokopelli::SCO::Meeting.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @meeting.save
      @host = Kokopelli::Principal::Host.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password"
      )
      @host.save
      @meeting.authenticate(@host,:host)
      @host.permissions_on(@meeting).should eql(:host)
    end

  end
  
  describe ".archives" do
    
    it "should return an empty array if no valid archive for this meeting exists" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-expanded-contents&sco-id=1036115664&filter-icon=archive", :empty)
      @meeting = Kokopelli::SCO::Meeting.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @meeting.save
      @meeting.archives.should be_empty
    end
    
    it "should return an array of valid archives if any archive exists for this meeting" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-expanded-contents&sco-id=1036115664&filter-icon=archive")
      @meeting = Kokopelli::SCO::Meeting.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @meeting.save
      @meeting.archives.should_not be_empty
      @meeting.archives.each { |archive| archive.class.should eql(Kokopelli::SCO::Archive) }
    end
    
  end
  
  describe ".archive_url" do
    
    it "should return nil if .archives has no archives" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-expanded-contents&sco-id=1036115664&filter-icon=archive", :empty)
      @meeting = Kokopelli::SCO::Meeting.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @meeting.save
      @meeting.archive_url.should be_nil
    end
    
    it "should return a proper url if .archives contains any archives" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("sco-shortcuts")
      FakeWeb::Mapping.build("sco-update&date-begin=2010-02-04T18:03:38-08:00&date-end=2010-02-04T19:03:38-08:00&description=this%20is%20some%20description&folder-id=1030182069&name=SCO&source-sco-id=1030182073&type=meeting&url-path=sco_path")
      FakeWeb::Mapping.build("permissions-update&acl-id=1036115664&principal-id=public-access&permission-id=denied")
      FakeWeb::Mapping.build("sco-expanded-contents&sco-id=1036115664&filter-icon=archive")
      @meeting = Kokopelli::SCO::Meeting.new(
        :type => "meeting",
        :source_id => "1030182073",
        :name => "SCO",
        :url_path => "sco_path",
        :icon => "meeting",
        :starts_at => Time.parse("2010-02-04T18:03:38-08:00"),
        :ends_at => Time.parse("2010-02-04T19:03:38-08:00"),
        :description => "this is some description"
      )
      @meeting.save
      @meeting.archive_url.should_not be_nil
      @meeting.archive_url.should eql("http://" + KOKOPELLI[:domain] + "/p38182167/")
    end
    
  end

end