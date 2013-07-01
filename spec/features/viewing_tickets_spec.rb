require 'spec_helper'

feature 'Viewing tickets' do
  before do
    user = FactoryGirl.create(:user)

    tm2 = FactoryGirl.create(:project, name: 'TextMate 2')
    t1 = FactoryGirl.create(:ticket,
                       project: tm2,
                       title: 'Make it shiny!',
                       description: 'Gradients! Starbursts! Oh my!')
    t1.update(user: user)

    ie = FactoryGirl.create(:project, name: 'Internet Explorer')
    t2 = FactoryGirl.create(:ticket,
                       project: ie,
                       title: 'Standards compliance',
                       description: 'Isnt a joke')
    t2.update(user: user)

    define_permission!(user, :view, tm2)
    define_permission!(user, :view, ie)

    sign_in_as!(user)

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

