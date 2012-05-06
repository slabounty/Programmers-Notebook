require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    it "should have the content 'Programmers\' Notebook'" do
      visit '/pages/home'
      page.should have_content('Programmers\' Notebook')
    end
  end

  describe "Contact page" do
    it "should have the content 'Programmers\' Notebook Contact'" do
      visit '/pages/contact'
      page.should have_content('Programmers\' Notebook Contact')
    end
  end
  describe "About page" do
    it "should have the content 'About'" do
      visit '/pages/about'
      page.should have_content('About')
    end
  end
end
