require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::Principal::Admin do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::Principal::Admin object with instance variables retained" do
      Kokopelli::Principal::Admin.new.class.should eql(Kokopelli::Principal::Admin)
      @admin = Kokopelli::Principal::Admin.new(
      :id                => "12345",
      :account_id        => "54321",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.id.should eql("12345")
      @admin.account_id.should eql("54321")
      @admin.has_children.should be_false
      @admin.is_primary.should be_false
      @admin.is_hidden.should be_false
      @admin.training_group_id.should be_blank
      @admin.name.should eql("Base Obj")
      @admin.type.should eql("user")
      @admin.login.should eql("user@test.com")
      @admin.password.should eql("password")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.id.should eql("1035814880")
      @admin.account_id.should eql("1030182041")
      @admin.has_children.should be_false
      @admin.is_primary.should be_false
      @admin.is_hidden.should be_false
      @admin.name.should eql("Base Obj")
      @admin.login.should eql("user@test.com")
      @admin.type.should eql("user")
      @admin.password.should eql("password")
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.update_attributes(
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "1234",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      @admin.has_children.should be_true
      @admin.is_primary.should be_true
      @admin.is_hidden.should be_true
      @admin.training_group_id.should eql("1234")
      @admin.name.should eql("Other Obj")
      @admin.login.should eql("other_user@test.com")
      @admin.type.should eql("user")
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principals-delete&principal-id=1035814880")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin = Kokopelli::Principal::Admin.find(@admin.id)
      @admin.class.should eql(Kokopelli::Principal::Admin)
      @admin.id.should eql("1035814880")
      @admin.destroy
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880", :empty)
      Kokopelli::Principal::Admin.find(@admin.id).should be_nil
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::Principal::Admin.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Admin without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty array if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true", :empty)
      Kokopelli::Principal::Admin.find(:all).should eql([])
    end

    it "should return an array of Kokopelli::Principal:Admin objects if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true")
      @admins = Kokopelli::Principal::Admin.find(:all)
      @admins.class.should eql(Array)
      @admins.each do |admin|
        admin.class.should eql(Kokopelli::Principal::Admin)
        admin.type.should eql("user")
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true")
      Kokopelli::Principal::Admin.all.should eql(Kokopelli::Principal::Admin.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true", :empty)
      @admin = Kokopelli::Principal::Admin.find(:first)
      @admin.should be_nil
    end

    it "should return a single Kokopelli::Principal::Admin object if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true")
      @admin = Kokopelli::Principal::Admin.find(:first)
      @admin.class.should eql(Kokopelli::Principal::Admin)
      @admin.type.should eql("user")
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true")
      Kokopelli::Principal::Admin.first.should eql(Kokopelli::Principal::Admin.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return a single Kokopelli::Principal::Admin object if a result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880")
      @admin = Kokopelli::Principal::Admin.find("1035814880")
      @admin.class.should eql(Kokopelli::Principal::Admin)
      @admin.id.should eql("1035814880")
      @admin.account_id.should eql("1030182041")
      @admin.login.should eql("user@test.com")
      @admin.type.should eql("user")
      @admin.has_children.should be_false
      @admin.is_primary.should be_false
      @admin.is_hidden.should be_false
      @admin.training_group_id.should be_blank
      @admin.name.should eql("Base Obj")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::Principal::Admin.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Admin with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-list&filter-type=admins")
      FakeWeb::Mapping.build("principal-list&group-id=1030182055&filter-is-member=true&filter-principal-id=1035814880")
      @first = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @first.save
      @second = @first.reload!
      @first.account_id.should eql(@second.account_id)
      @first.has_children.should eql(@second.has_children)
      @first.is_primary.should eql(@second.is_primary)
      @first.is_hidden.should eql(@second.is_hidden)
      @first.training_group_id.should eql(@second.training_group_id)
      @first.name.should eql(@second.name)
      @first.login.should eql(@second.login)
      @first.type.should eql(@second.type)
    end

  end

  describe ".valid?" do

    it "should be valid" do
      @admin = Kokopelli::Principal::Admin.new
      @admin.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record if the object has no @id" do
      @admin = Kokopelli::Principal::Admin.new
      @admin.should be_new_record
    end

    it "should not be a new result if the object has an @id" do
      @admin = Kokopelli::Principal::Admin.new(:id => "12345")
      @admin.should_not be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @admin = Kokopelli::Principal::Admin.new
      @clone = @admin
      @admin.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @admin = Kokopelli::Principal::Admin.new(:id => "12345")
      @clone = Kokopelli::Principal::Admin.new(:id => "54321")
      @admin.eql?(@clone).should be_false
    end

  end

  describe ".signin" do

    it "should return true if the signin succeeds and should store session" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.signin.should be_true
      @admin.session.should eql("na1breezaspo5qded43ka7fh")
    end

    it "should return raise Kokopelli::Exception::InternalError if the signin fails" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      FakeWeb::Mapping.build("login&login=other_user@test.com&password=newpassword")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      lambda { @admin.signin }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=login&login=other_user@test.com&password=newpassword)")
    end

  end

  describe ".signout" do

    it "should return true on logout" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      FakeWeb::Mapping.build("logout")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.signin.should be_true
      @admin.signout.should be_true
      @admin.should_not be_logged_in
    end

  end

  describe ".email" do

    it "should return the same instance variable value as login" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.email.should eql(@admin.login)
    end

  end

  describe ".stale?" do

    it "should return true if the @stale_datetime is recent" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      @admin = Kokopelli::Principal::Admin.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @admin.save
      @admin.signin
      @admin.should_not be_stale
    end

  end

end