require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::Principal::User do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::Principal::User object with instance variables retained" do
      Kokopelli::Principal::User.new.class.should eql(Kokopelli::Principal::User)
      @user = Kokopelli::Principal::User.new(
      :id                => "12345",
      :account_id        => "54321",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.id.should eql("12345")
      @user.account_id.should eql("54321")
      @user.has_children.should be_false
      @user.is_primary.should be_false
      @user.is_hidden.should be_false
      @user.training_group_id.should be_blank
      @user.name.should eql("Base Obj")
      @user.type.should eql("user")
      @user.login.should eql("user@test.com")
      @user.password.should eql("password")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user.id.should eql("1035814880")
      @user.account_id.should eql("1030182041")
      @user.has_children.should be_false
      @user.is_primary.should be_false
      @user.is_hidden.should be_false
      @user.name.should eql("Base Obj")
      @user.login.should eql("user@test.com")
      @user.type.should eql("user")
      @user.password.should eql("password")
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user.update_attributes(
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "1234",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      @user.has_children.should be_true
      @user.is_primary.should be_true
      @user.is_hidden.should be_true
      @user.training_group_id.should eql("1234")
      @user.name.should eql("Other Obj")
      @user.login.should eql("other_user@test.com")
      @user.type.should eql("user")
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035814880&filter-type=user")
      FakeWeb::Mapping.build("principals-delete&principal-id=1035814880")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user = Kokopelli::Principal::User.find(@user.id)
      @user.class.should eql(Kokopelli::Principal::User)
      @user.id.should eql("1035814880")
      @user.destroy
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035814880&filter-type=user", :empty)
      Kokopelli::Principal::User.find(@user.id).should be_nil
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::Principal::User.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::User without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user", :empty)
      Kokopelli::Principal::User.find(:all).should eql([])
    end

    it "should return an Array of Kokopelli::Principal::User object if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      @users = Kokopelli::Principal::User.find(:all)
      @users.class.should eql(Array)
      @users.should_not be_empty
      @users.each do |user|
        user.class.should eql(Kokopelli::Principal::User)
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      Kokopelli::Principal::User.all.should eql(Kokopelli::Principal::User.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return a single Kokopelli::Principal::User object if any results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      @user = Kokopelli::Principal::User.find(:first)
      @user.class.should eql(Kokopelli::Principal::User)
    end

    it "should return nil if no results are found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user", :empty)
      @user = Kokopelli::Principal::User.find(:first)
      @user.should be_nil
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-type=user")
      Kokopelli::Principal::User.first.should eql(Kokopelli::Principal::User.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return a single Kokopelli::Principal::User object if a result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1030094617&filter-type=user")
      @user = Kokopelli::Principal::User.find("1030094617")
      @user.class.should eql(Kokopelli::Principal::User)
      @user.id.should eql("1030094617")
      @user.account_id.should eql("1030182041")
      @user.login.should eql("ryan.moran@gmail.com")
      @user.type.should eql("user")
      @user.has_children.should be_false
      @user.is_primary.should be_false
      @user.is_hidden.should be_false
      @user.training_group_id.should be_blank
      @user.name.should eql("Ryan Moran")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::Principal::User.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::User with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035814880&filter-type=user")
      @first = Kokopelli::Principal::User.new(
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
      @user = Kokopelli::Principal::User.new
      @user.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record if the object has no @id" do
      @user = Kokopelli::Principal::User.new
      @user.should be_new_record
    end

    it "should not be a new result if the object has an @id" do
      @user = Kokopelli::Principal::User.new(:id => "12345")
      @user.should_not be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @user = Kokopelli::Principal::User.new
      @clone = @user
      @user.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @user = Kokopelli::Principal::User.new(:id => "12345")
      @clone = Kokopelli::Principal::User.new(:id => "54321")
      @user.eql?(@clone).should be_false
    end

  end

  describe ".signin" do

    it "should return true if the signin succeeds and should store session" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user.signin.should be_true
      @user.session.should eql("na1breezaspo5qded43ka7fh")
    end

    it "should return raise Kokopelli::Exception::InternalError if the signin fails" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("principal-update&principal-id=1035814880&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true&password=newpassword&email=other_user@test.com")
      FakeWeb::Mapping.build("login&login=other_user@test.com&password=newpassword")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "",
      :name              => "Other Obj",
      :login             => "other_user@test.com",
      :password          => "newpassword")
      lambda { @user.signin }.should raise_error(Kokopelli::Exception::InternalError, "Failed Request: url(https://admin.acrobat.com/api/xml?action=login&login=other_user@test.com&password=newpassword)")
    end

  end

  describe ".signout" do

    it "should return true on logout" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      FakeWeb::Mapping.build("login&login=user@test.com&password=password")
      FakeWeb::Mapping.build("logout")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user.signin.should be_true
      @user.signout.should be_true
      @user.should_not be_logged_in
    end

  end

  describe ".email" do

    it "should return the same instance variable value as login" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false&password=password&email=user@test.com")
      @user = Kokopelli::Principal::User.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :password          => "password")
      @user.save
      @user.email.should eql(@user.login)
    end

  end

end