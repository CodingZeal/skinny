require 'spec_helper'

describe 'user accounts' do
  describe "the length of the firstname" do
    # TODO: all cases are invalid because of the password and not the name alone
    # TODO: we never cover the other

    it "should not be super long" do
      user = User.new(firstname: "really really really really super super super long firstname that is crazy long")
      user.valid?.should_not == true
    end

    it "should not be super short" do
      # TODO: later conflicts with Capitalization requirement
      user = User.new(firstname: "sht")
      user.valid?.should_not == true
    end

    it "exists" do
      user = User.new(firstname: "")
      user.valid?.should_not == true
    end

    it "shouldn't have weird characters" do
      # TODO: later conflicts with password length
      user = User.new(firstname: "*&^&^$&")
      user.valid?.should_not == true
    end

  end

  describe "the user's email address" do
    it "should not accept an invalid format" do
      # TODO: password fails when requirements change to add capitals and numbers
      # TODO: permutation example
      user = User.new(email: "not email")
      user.valid?.should_not == true
    end
  end

  describe "updating the email address" do
    # TODO: never tested that the email changed.  We've assumed that due to the valid? method returning true
    # May fail when update_attribute silently discards the value
    # May fail when requirements of the object change
    it "should still test the validation" do
      user = User.create(firstname: "Jimmy Jim", password: "password", email: "admin@example.com")
      user.valid?.should == true
      user.email = "admin2@example.com"
      user.save
      user.valid?.should == true
    end
  end

  describe "password requirements" do
    # TODO: Single expectation principle
    it "doesn't allow a passoword that's less than 8 characters and matches the firstname" do
      user = User.create(firstname: "Jimmy Jim", password: "passwrd", email: "admin@example.com")
      user.valid?.should_not == true
    end
  end

  describe "permissions and abilities" do
    let(:page) { double(:page) }
    let(:user) { User.new }

    before do
      user.permissions << [:edit, page]
    end

    it "has the permission to edit the page" do
      expect {
        raise_error = true
        user.permissions.each do |set|
          if set[0] == :edit and set[1] == page
            raise_error = false
          end
        end
        raise if raise_error
      }.not_to raise_error
    end

    it { expect(user).to have_permission_to(:edit, page) }
  end
end
