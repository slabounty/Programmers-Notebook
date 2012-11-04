require 'spec_helper'

describe "NotePages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "note creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a note" do
        expect { click_button "Post" }.to_not change(Note, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before do 
        fill_in 'note_description', with: "Lorem ipsum" 
        fill_in 'note_code', with: "Ipsum lorem"
      end

      it "should create a note" do
        expect { click_button "Post" }.to change(Note, :count).by(1)
      end
    end
  end

  describe "note showing" do
    let(:note) { FactoryGirl.create(:note) }
    before do 
      visit note_path(note) 
    end

    describe "page" do
      it {should have_selector('h3', text: "Note:")}
      it {should have_css('div.fb-like')}
      # it {should have_css('div.twitter-button')}
      # it {should have_selector('iframe.twitter-share-button')}
      it {should have_selector('input', value: "Add my comment")}
    end

  end

  describe "note destruction" do
    before { FactoryGirl.create(:note, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a note" do
        expect { click_link "delete" }.to change(Note, :count).by(-1)
      end
    end
  end

end
