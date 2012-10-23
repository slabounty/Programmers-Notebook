require 'spec_helper'

describe Note do
  let(:user) { FactoryGirl.create(:user) }
  before { @note = user.notes.build(code: "Lorem ipsum", description: "Ipsum lorem") }

  subject { @note }

  it { should respond_to(:syntax_highlighted_code) }
  it { should respond_to(:code) }
  it { should respond_to(:code_tags) }
  it { should respond_to(:description) }
  it { should respond_to(:nonpublic) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
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
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
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

  describe "with nonpublic default" do
    it { @note.nonpublic.should == false }
  end

  describe "have tags" do
    before do 
      @note.code_tags = ["tag1", "tag2"] 
      @note.save!
      @tagged_note = Note.tagged_with(["tag1"]).first 
    end
    it { @note.code_tags.should include "tag1" }
    it { @note.code_tags.should include "tag2" }
    it { should == @tagged_note }
  end
end
