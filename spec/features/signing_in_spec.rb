require 'spec_helper'

feature 'Signing in' do
  scenario 'with valid credentials works successfully' do
    user = FactoryGirl.create(:user)

    visit '/'
    click_link 'Sign in'
    fill_in 'Username', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully')
  end
end

