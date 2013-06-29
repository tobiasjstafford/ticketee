require 'spec_helper'

feature 'hidden links' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }

  context 'anon users' do
    scenario 'can not see the "New Project" link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'can not see the "Edit Project" link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'can not see the "Destroy Project" link' do
      visit project_path(project)
      assert_no_link_for 'Destroy Project'
    end
  end

  context 'regular users' do
    before { sign_in_as!(user) }
    scenario 'can not see the "New Project" link' do
      visit '/'
      assert_no_link_for 'New Project'
    end

    scenario 'can not see the "Edit Project" link' do
      visit project_path(project)
      assert_no_link_for 'Edit Project'
    end

    scenario 'can not see the "Destroy Project" link' do
      visit project_path(project)
      assert_no_link_for 'Destroy Project'
    end
  end

  context 'admin users' do
    before { sign_in_as!(admin_user) }
    scenario 'can see the "New Project" link' do
      visit '/'
      assert_link_for 'New Project'
    end

    scenario 'can see the "Edit Project" link' do
      visit project_path(project)
      assert_link_for 'Edit Project'
    end

    scenario 'can see the "Destroy Project" link' do
      visit project_path(project)
      assert_link_for 'Destroy Project'
    end
  end
end
