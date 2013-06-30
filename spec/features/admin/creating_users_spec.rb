require 'spec_helper'

feature 'Creating users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    sign_in_as!(admin_user)

    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  scenario 'Creating a new user as an admin' do
    fill_in 'Email', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create User'

    expect(page).to have_content 'User has been created'
  end
end

