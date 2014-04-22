require 'spec_helper'

describe 'user accounts' do
  describe "the length of the name" do
    # TODO: all cases are invalid because of the password and not the name alone
    # TODO: we never cover the other

    it "should not be super long" do
      user = User.build(name: "really really really really super super super long name that is crazy long")
      user.valid?.should_not == true
    end

    it "should not be super short" do
      # TODO: later conflicts with Capitalization requirement
      user = User.build(name: "sht")
      user.valid?.should_not == true
    end

    it "exists" do
      user = User.build(name: "")
      user.valid?.should_not == true
    end

    it "shouldn't have weird characters" do
      # TODO: later conflicts with password length
      user = User.build(name: "*&^&^$&")
      user.valid?.should_not == true
    end

  end

  describe "the user's email address" do
    it "accepts the normal format" do
      # TODO: password fails when requirements change to add capitals and numbers
      # TODO: permutation example
      user = User.build(name: "Jimmy Jim", password: "password", email: "admin@example.com")
      user.valid?.should_not == false
    end
  end

  describe "updating the email address" do
    # TODO: never tested that the email changed.  We've assumed that due to the valid? method returning true
    # May fail when update_attribute silently discards the value
    # May fail when requirements of the object change
    it "should still test the validation" do
      user = User.create(name: "Jimmy Jim", password: "password", email: "admin@example.com")
      user.valid?.should == true
      user.email = "admin2@example.com"
      user.save
      user.valid?.should == true
    end
  end

  describe "password requirements" do
    # TODO: Single expectation principle
    it "doesn't allow a passoword that's less than 8 characters and matches the name" do
      user = User.create(name: "Jimmy Jim", password: "passwrd", email: "admin@example.com")
      user.valid?.should_not == true
    end
  end
end
