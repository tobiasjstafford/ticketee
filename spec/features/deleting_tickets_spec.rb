require 'spec_helper'

feature 'Deleting Tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do
    t = FactoryGirl.create(:ticket, project: project)
    t.update(user: user)
    t
  end
    

  before do
    define_permission!(user, :view, project)
    define_permission!(user, :delete_tickets, project)
    sign_in_as!(user)

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

