require 'spec_helper'

feature 'Editing tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do
    t = FactoryGirl.create(:ticket, project: project)
    t.update(user: user)
    t
  end

  before do
    define_permission!(user, :view, project)
    define_permission!(user, :edit_tickets, project)
    sign_in_as!(user)

    visit '/'
    click_link project.name
    click_link ticket.title
    click_link 'Edit Ticket'
  end

  scenario 'Successfully editing a ticket' do
    fill_in 'Title', with: 'Make it really shiny!'
    click_button 'Update Ticket'

    expect(page).to have_content('Ticket has been updated')

    within('#ticket h2') do
      expect(page).to have_content('Make it really shiny!')
    end

    expect(page).to_not have_content ticket.title
  end

  scenario 'Trying to edit an invalid ticket' do
    fill_in 'Title', with: ''
    click_button 'Update Ticket'

    expect(page).to have_content('Ticket has not been updated')
  end
end

