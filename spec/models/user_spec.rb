require 'spec_helper'

describe 'user accounts' do
  describe "the length of the firstname" do

    it "should not be super long" do
      user = User.new(firstname: "really really really really super super super long firstname that is crazy long")
      user.valid?.should_not == true
    end

    it "should not be super short" do
      user = User.new(firstname: "sht")
      user.valid?.should_not == true
    end

    it "exists" do
      user = User.new(firstname: "")
      user.valid?.should_not == true
    end

    it "shouldn't have weird characters" do
      user = User.new(firstname: "*&^&^$&")
      user.valid?.should_not == true
    end

  end

  describe "the user's email address" do
    it "should not accept an invalid format" do
      user = User.new(email: "not email")
      user.valid?.should_not == true
    end
  end

  describe "updating the email address" do
    it "should still test the validation" do
      user = User.create(firstname: "Jimmy Jim", password: "password", email: "admin@example.com")
      user.valid?.should == true
      user.email = "admin2@example.com"
      user.save
      user.valid?.should == true
    end
  end

  describe "password requirements" do
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
