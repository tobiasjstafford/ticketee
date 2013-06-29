require 'spec_helper'

feature 'Creating Projects' do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))

    visit '/'

    click_link 'New Project'
  end

  scenario 'can create a project' do
    fill_in 'Name', with: 'Textmate 2'
    fill_in 'Description', with: 'A text exitor for OS X'
    click_button 'Create Project'

    expect(page).to have_content('Project has been created')

    # check title
    project = Project.where(name: 'Textmate 2').first
    expect(page.current_url).to eql(project_url(project))

    title = 'Textmate 2 - Projects - Ticketee'
    expect(find('title').native.text).to have_content(title)
  end

  scenario 'can not create an invalid project' do
    click_button 'Create Project'

    expect(page).to have_content('Project has not been created')
    expect(page).to have_content("Name can't be blank")
  end
end

