require 'spec_helper'

describe "Pages" do
  describe "Home page" do
    it "should have the content 'Programmers\' Notebook'" do
      visit '/pages/home'
      page.should have_content('Programmers\' Notebook')
    end

    it "should have the title 'Home'" do
      visit '/pages/home'
      page.should have_selector('title',
                        :text => "Programmer's Notebook | Home")
    end
  end

  describe "Contact page" do
    it "should have the content 'Programmers\' Notebook Contact'" do
      visit '/pages/contact'
      page.should have_content('Programmers\' Notebook Contact')
    end

    it "should have the title 'Contact'" do
      visit '/pages/contact'
      page.should have_selector('title',
                        :text => "Programmer's Notebook | Contact")
    end
  end

  describe "About page" do
    it "should have the content 'About'" do
      visit '/pages/about'
      page.should have_content('About')
    end

    it "should have the title 'About'" do
      visit '/pages/about'
      page.should have_selector('title',
                        :text => "Programmer's Notebook | About")
    end
  end
end
