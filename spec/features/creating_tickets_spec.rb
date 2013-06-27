require 'spec_helper'

feature 'Creating tickets' do
  before do
    project = FactoryGirl.create(:project, name: 'Internet Explorer')
    user = FactoryGirl.create(:user)

    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link 'New Ticket'

    within('h1') { expect(page).to have_content('New Ticket') }
  end

  scenario 'Creating a valid ticket for a project' do
    fill_in 'Title', with: 'Non-standards Compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has been created')

    within '#ticket #author' do
      expect(page).to have_content('Created by sample@example.com')
    end
  end

  scenario 'Unable to create an invalid ticket' do
    click_button 'Create Ticket'

    expect(page).to have_content('Ticket has not been created')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'Descriptions must be longer than 10' do
    fill_in 'Title', with: 'Non-standards compliance'
    fill_in 'Description', with: 'it sucks'
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has not been created'
    expect(page).to have_content 'Description is too short'
  end
end

