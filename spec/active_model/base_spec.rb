require File.dirname(__FILE__) + '/../spec_helper'

describe Kokopelli::ActiveModel::Base do

  describe ".new" do

    it "should return a new Kokopelli::ActiveModel::Base object" do
      Kokopelli::ActiveModel::Base.new.class.should eql(Kokopelli::ActiveModel::Base)
    end

  end

  describe ".save" do

    it "should persist the record using an API call" do
      @active_model = Kokopelli::ActiveModel::Base.new
      lambda { @active_model.save }.should raise_error(ArgumentError, "HTTP request path is empty")
    end

  end

  describe ".update_attributes" do

    it "should persist the record with new attributes using an API call" do
      @active_model = Kokopelli::ActiveModel::Base.new
      lambda { @active_model.update_attributes }.should raise_error(ArgumentError, "HTTP request path is empty")
    end

  end

  describe ".destroy" do

    it "should destroy the persisted copy of the record using an API call" do
      @active_model = Kokopelli::ActiveModel::Base.new
      lambda { @active_model.destroy }.should raise_error(ArgumentError, "HTTP request path is empty")
    end

  end

  describe ".find without arguments" do

    it "should raise a RecordNotFound Error" do
      lambda { Kokopelli::ActiveModel::Base.find }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::ActiveModel::Base without ID")
    end

  end

  describe ".find(:all)" do

    it "should return an empty Array" do
      Kokopelli::ActiveModel::Base.find(:all).should eql([])
    end

    it "should act as alias to .all" do
      Kokopelli::ActiveModel::Base.all.should eql(Kokopelli::ActiveModel::Base.find(:all))
    end

  end

  describe ".find(:first)" do

    it "should return nil" do
      Kokopelli::ActiveModel::Base.find(:first).should eql(nil)
    end

    it "should act as alias to .first" do
      Kokopelli::ActiveModel::Base.first.should eql(Kokopelli::ActiveModel::Base.find(:first))
    end

  end

  describe ".find(:id)" do

    it "should return nil" do
      Kokopelli::ActiveModel::Base.find("12345").should eql(nil)
    end

    it "should raise a RecordNotFound Error if :id is not String" do
      lambda { Kokopelli::ActiveModel::Base.find(12345) }.should raise_error(Kokopelli::Exception::RecordNotFound, "Couldn't find Kokopelli::ActiveModel::Base with this ID")
    end

  end

  describe ".reload!" do

    it "should return the same object" do
      @first = Kokopelli::ActiveModel::Base.new
      @second = @first.reload!
      @first.should eql(@second)
    end

  end

  describe ".valid?" do

    it "should be valid" do
      @active_model = Kokopelli::ActiveModel::Base.new
      @active_model.should be_valid
    end

  end

  describe ".new_record?" do

    it "should be new record" do
      @active_model = Kokopelli::ActiveModel::Base.new
      @active_model.should be_new_record
    end

  end

  describe ".eql?(obj)" do

    it "should return true if the objects are the same" do
      @active_model = Kokopelli::ActiveModel::Base.new
      @clone = @active_model
      @active_model.eql?(@clone).should be_true
    end

    it "should return false if the objects are not the same" do
      @active_model = Kokopelli::ActiveModel::Base.new
      @clone = Kokopelli::ActiveModel::Base.new
      @active_model.eql?(@clone).should be_false
    end

  end

end