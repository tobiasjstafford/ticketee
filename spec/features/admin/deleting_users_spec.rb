require 'spec_helper'

feature 'Deleting users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(admin_user)

    visit '/'
    click_link 'Admin'
    click_link 'Users'
  end

  scenario 'Deleting a user' do
    click_link user.email
    click_link 'Delete User'

    expect(page).to have_content('User has been deleted')
    within '#users' do
      expect(page).to have_no_content(user.email)
    end
  end

  scenario 'Can not delete yourself' do
    click_link admin_user.email
    click_link 'Delete User'

    expect(page).to have_content 'You can not delete yourself'
    within '#users' do
      expect(page).to have_content admin_user.email
    end
  end
end

