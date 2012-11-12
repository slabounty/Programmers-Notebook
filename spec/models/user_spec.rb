# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", 
                            password: "foobar", password_confirmation: "foobar" ) }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:notes) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }
  it { should respond_to(:interests) }

  it { should be_valid }

  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }
    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }
  
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
  
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before {@user.save}
    its (:remember_token) { should_not be_blank }
  end

  describe "note association" do
    before { @user.save }
    let!(:older_note) do
      FactoryGirl.create(:note, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_note) do
      FactoryGirl.create(:note, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right notes in the right order" do
      @user.notes.should == [newer_note, older_note]
    end

    it "should destroy associated notes" do
      notes = @user.notes
      @user.destroy
      notes.each do |note|
        Note.find_by_id(note.id).should be_nil
      end
    end

    describe "status" do
      let(:unfollowed_note) do
        FactoryGirl.create(:note, user: FactoryGirl.create(:user))
      end
      let(:followed_user) { FactoryGirl.create(:user) }
      let(:private_note) do
        FactoryGirl.create(:note, user: followed_user, nonpublic: true)
      end

      before do
        @user.save
        @user.follow!(followed_user)
      end

      its(:feed) { should include(newer_note) }
      its(:feed) { should include(older_note) }
      its(:feed) { should_not include(unfollowed_note) }
      its(:feed) { should_not include(private_note) }
      its(:feed) do
        followed_user.notes.each do |note|
          should include(note)
        end
      end 
      describe "tagging" do
        let(:ruby_note) { FactoryGirl.create(:note, user: @user, code_tags: ["ruby"]) }
        let(:bash_note) { FactoryGirl.create(:note, user: @user, code_tags: ["bash"]) }

        it "should have the ruby note when ruby is tagged in the feed" do
          @user.feed(true, ["ruby"]).should include(ruby_note)
        end

        it "should not have the bash note when ruby is tagged in the feed" do
          @user.feed(true, ["ruby"]).should_not include(bash_note)
        end

        
      end
    end
  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }    
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end

    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }

      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end
  end

  describe "interests" do
    before do 
      @user.interests = ["interest1", "interest2"] 
      @user.save!
      @tagged_user = User.tagged_with(["interest1"]).first 
    end
    it { @user.interests.should include "interest1" }
    it { @user.interests.should include "interest2" }
    it { should == @tagged_user }
    it "should be interested in" do
      User.interested_in?("interest1").should include(@user)
    end
    it "should not be interested in" do
      User.interested_in?("interest3").should_not include(@user)
    end
  end

end
