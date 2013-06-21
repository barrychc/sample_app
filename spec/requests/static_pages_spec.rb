require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
    it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    page.should have_selector 'title', text: full_title('')
  end    
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
#        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
#        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        30.times do |n| 
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum #{n+1}") 
        end
        sign_in user
        visit root_path
      end

      it { should have_content(user.feed.count) }#10.5.1
#      it { should have_selector('div.pagination') } #10.5.2 no idea why caused error
        it "should render the user's paginated feed" do
        Micropost.paginate(page: 1).each do |micropost|
          page.should have_selector("li##{micropost.id}", text: micropost.content)
        end

#        user.feed.each do |item|
#          page.should have_selector("li##{item.id}", text: item.content)
          #the first # in li##{item.id} is Capybara syntax for a CSS id,
          #whereas the second # is the beginning of a Ruby string interpolation #{}
#        end


      end

=begin
      #Exercise 10.5.4 not working yet
      describe "should not display delete link for microposts created by others" do
        let(:user2) { FactoryGirl.create(:user) }
        before {FactoryGirl.create(:micropost, user: user2, content: "Dolor sit amet")}
        it { should_not have_link('delete') }
      end      
=end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
    it { should have_selector('title', text: full_title('Contact')) }
  end
end