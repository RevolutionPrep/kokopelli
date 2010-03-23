require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::Principal::Guest do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::Principal::Guest object with instance variables retained" do
      Kokopelli::Principal::Guest.new.class.should eql(Kokopelli::Principal::Guest)
      @guest = Kokopelli::Principal::Guest.new(
      :id                => "12345",
      :account_id        => "54321",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.id.should eql("12345")
      @guest.account_id.should eql("54321")
      @guest.has_children.should be_false
      @guest.is_primary.should be_false
      @guest.is_hidden.should be_false
      @guest.training_group_id.should be_blank
      @guest.name.should eql("Base Obj")
      @guest.type.should eql("user")
      @guest.login.should eql("user@test.com")
      @guest.password.should eql("password")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user",
      :password          => "password")
      @guest.save
      @guest.id.should eql("1035816176")
      @guest.account_id.should eql("1030182041")
      @guest.has_children.should be_false
      @guest.is_primary.should be_false
      @guest.is_hidden.should be_false
      @guest.name.should eql("Base Obj")
      @guest.login.should eql("user@test.com")
      @guest.type.should eql("guest")
      @guest.password.should eql("password")
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035816176&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest.update_attributes(
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "1234",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      @guest.has_children.should be_true
      @guest.is_primary.should be_true
      @guest.is_hidden.should be_true
      @guest.training_group_id.should eql("1234")
      @guest.name.should eql("Other Obj")
      @guest.login.should eql("other_user@test.com")
      @guest.type.should eql("user")
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principals-delete&principal-id=1035816176")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035816176&filter-type=user")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest = Kokopelli::Principal::Guest.find(@guest.id)
      @guest.class.should eql(Kokopelli::Principal::Guest)
      @guest.id.should eql("1035816176")
      @guest.destroy
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035816176&filter-type=user", :empty)
      Kokopelli::Principal::Guest.find(@guest.id).should be_nil
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::Principal::Guest.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Guest without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user", :empty)
      Kokopelli::Principal::Guest.find(:all).should eql([])
    end

    it "should return an array of Kokopelli::Principal::Guest objects if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      @guests = Kokopelli::Principal::Guest.find(:all)
      @guests.class.should eql(Array)
      @guests.each do |guest|
        guest.class.should eql(Kokopelli::Principal::Guest)
        guest.type.should eql("user")
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      Kokopelli::Principal::Guest.all.should eql(Kokopelli::Principal::Guest.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user", :empty)
      @guest = Kokopelli::Principal::Guest.find(:first)
      @guest.should be_nil
    end

    it "should return a single Kokopelli::Principal::Guest object if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      @guest = Kokopelli::Principal::Guest.find(:first)
      @guest.class.should eql(Kokopelli::Principal::Guest)
      @guest.type.should eql("user")
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      Kokopelli::Principal::Guest.first.should eql(Kokopelli::Principal::Guest.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return a single Kokopelli::Principal::Guest object if a result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035816176&filter-type=user")
      @guest = Kokopelli::Principal::Guest.find("1035816176")
      @guest.class.should eql(Kokopelli::Principal::Guest)
      @guest.id.should eql("1035816176")
      @guest.account_id.should eql("1030182041")
      @guest.login.should eql("user@test.com")
      @guest.type.should eql("user")
      @guest.has_children.should be_false
      @guest.is_primary.should be_false
      @guest.is_hidden.should be_false
      @guest.training_group_id.should be_blank
      @guest.name.should eql("Base Obj")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::Principal::Guest.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Guest with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035814880&filter-type=user")
      @first = Kokopelli::Principal::Guest.new(
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
      @guest = Kokopelli::Principal::Guest.new
      @guest.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record if the object has no @id" do
      @guest = Kokopelli::Principal::Guest.new
      @guest.should be_new_record
    end

    it "should not be a new result if the object has an @id" do
      @guest = Kokopelli::Principal::Guest.new(:id => "12345")
      @guest.should_not be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @guest = Kokopelli::Principal::Guest.new
      @clone = @guest
      @guest.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @guest = Kokopelli::Principal::Guest.new(:id => "12345")
      @clone = Kokopelli::Principal::Guest.new(:id => "54321")
      @guest.eql?(@clone).should be_false
    end

  end

  describe ".signin" do

    it "should return true if the signin succeeds and should store session" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest.signin.should be_true
      @guest.session.should eql("na1breezaspo5qded43ka7fh")
    end

    it "should return raise Kokopelli::Exception::InternalError if the signin fails" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035816176&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      FakeWeb::Mapping.build("login&login=other_user@test.com&password=newpassword")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      lambda { @guest.signin }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=login&login=other_user@test.com&password=newpassword)")
    end

  end

  describe ".signout" do

    it "should return true on logout" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      FakeWeb::Mapping.build("logout")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest.signin.should be_true
      @guest.signout.should be_true
      @guest.should_not be_logged_in
    end

  end

  describe ".email" do

    it "should return the same instance variable value as login" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=guest&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @guest = Kokopelli::Principal::Guest.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @guest.save
      @guest.email.should eql(@guest.login)
    end

  end

end