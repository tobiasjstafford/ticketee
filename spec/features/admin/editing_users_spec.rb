require 'spec_helper'

feature 'Editing users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(admin_user)

    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link user.email
    click_link 'Edit User'
  end

  scenario "Updating a user's detail" do
    fill_in 'Email', with: 'newguy@example.com'
    click_button 'Update User'

    expect(page).to have_content 'User has been updated'

    within '#users'  do
      expect(page).to have_content 'newguy@example.com'
      expect(page).to_not have_content user.name
    end
  end

  scenario "Toggling a user's admin status" do
    check 'Is an admin?'
    click_button 'Update User'

    expect(page).to have_content 'User has been updated'

    within '#users' do
      expect(page).to have_content "#{user.email} (Admin)"
    end
  end
end

