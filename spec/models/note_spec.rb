require 'spec_helper'

describe Note do
  let(:user) { FactoryGirl.create(:user) }
  before { @note = user.notes.build(code: "Lorem ipsum", description: "Ipsum lorem") }

  subject { @note }

  it { should respond_to(:syntax_highlighted_code) }
  it { should respond_to(:code) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @note.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Note.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @note.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @note.description = " " }
    it { should_not be_valid }
  end

  describe "with blank code" do
    before { @note.code = " " }
    it { should_not be_valid }
  end
end
