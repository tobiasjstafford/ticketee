require 'spec_helper'

feature 'User Profiles' do
  scenario 'viewing profile' do
    user = FactoryGirl.create(:user)

    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end
end

feature 'Editing Users' do
  scenario 'Updating a user' do
    user = FactoryGirl.create(:user)

    visit user_path(user)

    click_link 'Edit Profile'

    fill_in 'Email', with: 'new@fakeisp.com'
    click_button 'Update Profile'

    expect(page).to have_content('Profile has been updated')
    expect(page).to have_content('new@fakeisp.com')
  end
end

