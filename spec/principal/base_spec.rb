require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::Principal::Base do

  before(:all) do
    FakeWeb.allow_net_connect = KOKOPELLI[:allow_net_connect]
  end

  after(:each) do
    FakeWeb.clean_registry
  end

  describe ".new" do

    it "should return a new Kokopelli::Principal::Base object with instance variables retained" do
      Kokopelli::Principal::Base.new.class.should eql(Kokopelli::Principal::Base)
      @principal = Kokopelli::Principal::Base.new(
      :id                => "12345",
      :account_id        => "54321",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user")
      @principal.id.should eql("12345")
      @principal.account_id.should eql("54321")
      @principal.has_children.should be_false
      @principal.is_primary.should be_false
      @principal.is_hidden.should be_false
      @principal.training_group_id.should be_blank
      @principal.name.should eql("Base Obj")
      @principal.type.should eql("user")
      @principal.login.should eql("user@test.com")
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false")
      @principal = Kokopelli::Principal::Base.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user")
      @principal.save
      @principal.id.should eql("1035770400")
      @principal.account_id.should eql("1030182041")
      @principal.has_children.should be_false
      @principal.is_primary.should be_false
      @principal.is_hidden.should be_false
      @principal.name.should eql("Base Obj")
      @principal.login.should eql("user@test.com")
      @principal.type.should eql("user")
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false")
      FakeWeb::Mapping.build("principal-update&principal-id=1035770400&account-id=1030182041&training-group-id=1234&name=Other%20Obj&login=other_user@test.com&has-children=true&is-primary=true&is-hidden=true")
      @principal = Kokopelli::Principal::Base.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user")
      @principal.save
      @principal.update_attributes(
      :has_children      => true,
      :is_primary        => true,
      :is_hidden         => true,
      :training_group_id => "1234",
      :name              => "Other Obj",
      :login             => "other_user@test.com")
      @principal.has_children.should be_true
      @principal.is_primary.should be_true
      @principal.is_hidden.should be_true
      @principal.training_group_id.should eql("1234")
      @principal.name.should eql("Other Obj")
      @principal.login.should eql("other_user@test.com")
      @principal.type.should eql("user")
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false")
      FakeWeb::Mapping.build("principals-delete&principal-id=1035770400")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035770400")
      @principal = Kokopelli::Principal::Base.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user")
      @principal.save
      @principal = Kokopelli::Principal::Base.find(@principal.id)
      @principal.class.should eql(Kokopelli::Principal::Base)
      @principal.id.should eql("1035770400")
      @principal.destroy
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035770400", :empty)
      Kokopelli::Principal::Base.find(@principal.id).should be_nil
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::Principal::Base.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Base without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an array results" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list")
      @principals = Kokopelli::Principal::Base.find(:all)
      @principals.class.should eql(Array)
      @principals.each do |principal|
        principal.class.should eql(Kokopelli::Principal::Base)
      end
    end

    it "should act as alias to .all" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list")
      Kokopelli::Principal::Base.all.should eql(Kokopelli::Principal::Base.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return the first principal from the principal-list" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list")
      @principal = Kokopelli::Principal::Base.find(:first)
      @principal.class.should eql(Kokopelli::Principal::Base)
    end

    it "should act as alias to .first" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list")
      Kokopelli::Principal::Base.first.should eql(Kokopelli::Principal::Base.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return a single Kokopelli::Principal::Base object if a result is found" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1030094617")
      @principal = Kokopelli::Principal::Base.find("1030094617")
      @principal.class.should eql(Kokopelli::Principal::Base)
      @principal.id.should eql("1030094617")
      @principal.account_id.should eql("1030182041")
      @principal.login.should eql("ryan.moran@gmail.com")
      @principal.type.should eql("user")
      @principal.has_children.should be_false
      @principal.is_primary.should be_false
      @principal.is_hidden.should be_false
      @principal.training_group_id.should be_blank
      @principal.name.should eql("Ryan Moran")
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::Principal::Base.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::Principal::Base with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      FakeWeb::Mapping.build("login&login=ryan.moran@gmail.com&password=revprep123")
      FakeWeb::Mapping.build("principal-update&account-id=1030182041&name=Base%20Obj&login=user@test.com&type=user&has-children=false&is-primary=false&is-hidden=false")
      FakeWeb::Mapping.build("principal-list&filter-principal-id=1035770400")
      @first = Kokopelli::Principal::Base.new(
      :account_id        => "1030182041",
      :has_children      => false,
      :is_primary        => false,
      :is_hidden         => false,
      :training_group_id => "",
      :name              => "Base Obj",
      :login             => "user@test.com",
      :type              => "user")
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
      @principal = Kokopelli::Principal::Base.new
      @principal.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record if the object has no @id" do
      @principal = Kokopelli::Principal::Base.new
      @principal.should be_new_record
    end

    it "should not be a new result if the object has an @id" do
      @principal = Kokopelli::Principal::Base.new(:id => "12345")
      @principal.should_not be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @principal = Kokopelli::Principal::Base.new
      @clone = @principal
      @principal.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @principal = Kokopelli::Principal::Base.new(:id => "12345")
      @clone = Kokopelli::Principal::Base.new(:id => "54321")
      @principal.eql?(@clone).should be_false
    end

  end

end