require 'spec_helper'

describe "Pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('Programmer\'s Notebook') }
    it { should have_selector('title', text: full_title('Home')) }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:note, user: user, description: "Lorem ipsum", code: "Ipsum lorem")
        FactoryGirl.create(:note, user: user, description: "Dolor sit amet", code: "Amet sit dolor")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.description)
          page.should have_selector("li##{item.id}", text: item.code)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end

    end
  end

  describe "Contact page" do
    before { visit contact_path }
    it { should have_content('Programmers\' Notebook Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  describe "About page" do
    before { visit about_path }
      it { should have_content('About') }
      it { should have_selector('title', text: full_title('About')) }
  end

  describe "Help page" do
    before { visit help_path }
      it { should have_content('Help') }
      it { should have_selector('title', text: full_title('Help')) }
  end
end
