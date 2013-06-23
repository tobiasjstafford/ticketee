require 'spec_helper'

feature 'Viewing tickets' do
  before do
    tm2 = FactoryGirl.create(:project, name: 'TextMate 2')
    
    FactoryGirl.create(:ticket,
                       project: tm2,
                       title: 'Make it shiny!',
                       description: 'Gradients! Starbursts! Oh my!')

    ie = FactoryGirl.create(:project, name: 'Internet Explorer')

    FactoryGirl.create(:ticket,
                       project: ie,
                       title: 'Standards compliance',
                       description: 'Isnt a joke')

    visit '/'
  end

  scenario 'Listing tickets for a project' do
    click_link 'TextMate 2'

    expect(page).to have_content('Make it shiny!')
    expect(page).to have_no_content('Standards compliance')

    click_link 'Make it shiny!'

    within('#ticket h2') do
      expect(page).to have_content('Make it shiny!')
    end
    expect(page).to have_content('Gradients! Starbursts! Oh my!')
  end
end

