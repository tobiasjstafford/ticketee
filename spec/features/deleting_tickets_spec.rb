require 'spec_helper'

feature 'Deleting Tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project) }

  before do
    visit '/'

    click_link project.name
    click_link ticket.title
  end

  scenario 'Deletes a ticket successfully' do
    click_link 'Delete Ticket'

    expect(page.current_path).to eql(project_path(project))
    expect(page).to have_content('Ticket has been destroyed')

    expect(page).to_not have_content ticket.title
  end
end

