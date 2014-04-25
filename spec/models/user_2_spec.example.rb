require "spec_helper"

shared_examples_for User do |with_options|
  subject(:user) { User.new(name: name, email: email, admin: admin) }

  let(:name)  { with_options[:name]  || "Jimmy" }
  let(:email) { with_options[:email] || "jimmy@example.com" }
  let(:admin) { with_options[:admin] || false }

  it { expect(subject.name).to eq name }
  it { expect(subject.email).to eq email }
  it { expect(subject).not_to be_admin }

  context "when an admin" do
    let(:admin) { true }
    it { expect(subject).to be_admin }

    describe "permissions" do
    end
  end
end

shared_examples_for "a fullname with" do |names|
  let(:firstname) { "John" }
  let(:middlename) { "jim" }
  let(:lastname)  { "smith" }
  let(:suffix)  { "III" }
  let(:fullname) {
    fullname  = []
    fullname << firstname     if names.include? :firstname
    fullname << middlename    if names.include? :middlename
    fullname << lastname      if names.include? :lastname
    fullname  = fullname.join(' ')
    fullname += ", #{suffix}" if names.include? :suffix
    fullname
  }

  before do
    subject.stub(:firstname).and_return(firstname)
    subject.stub(:middlename).and_return(middlename)
    subject.stub(:lastname).and_return(lastname)
    subject.stub(:suffix).and_return(suffix)
  end

  it "combines available names" do
    expect(subject.fullname).to eql fullname
  end
end

shared_examples_for "permissible to" do |action, klass|

  before { subject.permissions << [action, klass] }

  it "has permission to #{action}" do
    expect(subject).to have_permission_to(action, klass)
  end
end

describe User do
  it_behaves_like User, name: "Bob"

  describe "#fullname" do
    it_behaves_like "a fullname with", [:firstname, :middlename, :lastname]
    it_behaves_like "a fullname with", [:firstname, :lastname]
    it_behaves_like "a fullname with", [:firstname, :lastname, :suffix]
    it_behaves_like "a fullname with", [:firstname, :middlename, :lastname, :suffix]
  end

  describe "permissions" do
    it_behaves_like "permissible to", :edit, Array
    it_behaves_like "permissible to", :read, Array
  end
end

