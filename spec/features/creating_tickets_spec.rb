require 'spec_helper'

feature 'Creating tickets' do
  before do
    FactoryGirl.create(:project, name: 'Internet Explorer')

    visit '/'
    click_link 'Internet Explorer'
    click_link 'New Ticket'
  end

  scenario 'Creating a valid ticket for a project' do
    fill_in 'Title', with: 'Non-standards Compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has been created')
  end

  scenario 'Unable to create an invalid ticket' do
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end

