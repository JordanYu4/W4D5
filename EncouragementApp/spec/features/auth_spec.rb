require 'spec_helper'
require 'rails_helper'

feature 'The sign up process' do
  scenario 'Has a new users sign up page' do

    visit new_user_url
    expect(page).to have_content('Sign up')

  end
  feature 'signing up a user' do

    before(:each) do
      visit new_user_url
      fill_in 'username', with: 'dan'
      fill_in 'password', with: 'abcdefg'
      click_on 'Sign up'
    end

    scenario 'shows the users username on their profile page after signing up' do
      expect(page).to have_content 'dan'
    end
    
  end
end
