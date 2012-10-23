require 'spec_helper'

describe Comment do
  let(:note) { FactoryGirl.create(:note) }
  before do 
    @comment = note.comments.build(comment: "Commentimus Maximus") 
  end

  subject { @comment }

  it {should respond_to(:note) }
  it {should respond_to(:user) }

  its(:note) { should == note }

  it { should be_valid }

  describe "when note_id is not present" do
    before { @comment.note_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to note_id" do
      expect do
        Comment.new(note_id: note.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "with blank comment" do
    before { @comment.comment = " " }
    it { should_not be_valid }
  end

end
