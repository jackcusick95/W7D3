require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content "Sign up user here"
  end

  feature 'signing up a user' do
    before(:each) do 
        visit new_user_url
        fill_in 'Username', :with => 'a_username'
        fill_in 'Password', :with => 'password123'
        click_on "Create user"
    end
    scenario 'shows username on the homepage after signup' do 
        expect(page).to have_content 'a_username'
    end

  end
end

feature 'logging in' do
    subject(:user) do
        FactoryBot.build(:user, username: 'a_username', password: 'password123')
    end
    before(:each) do 
        user.save
        visit new_session_url
        fill_in 'Username', :with => 'a_username'
        fill_in 'Password', :with => 'password123'
        click_on "Log in"
    end

    scenario 'shows username on the homepage after login' do
        visit users_url
        expect(page).to have_content 'a_username'
    end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do 
    visit users_url
    expect(page).to have_selector("input[type=submit][value='Log in']")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit users_url
    expect(page).to_not have_content 'Welcome'
  end

end