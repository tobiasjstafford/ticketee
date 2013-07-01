require 'spec_helper'

describe ProjectsController do

  let(:user) { FactoryGirl.create(:user) }

  context 'standard users' do
    before do
      sign_in(user)
    end

    { new: :get,
      create: :post,
      edit: :get,
      update: :patch,
      destroy: :delete }.each do |action, method|

      it "can not access the #{action} action" do
        send(method, action, id: FactoryGirl.create(:project))

        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql('You must be an admin to do that')
      end
    end

    it 'can not access a project without permission' do
      project = FactoryGirl.create(:project)
      get :show, id: project

      expect(response).to redirect_to projects_path
      expect(flash[:alert]).to eql 'The project you were looking for could not be found'
    end

    it "should display an error if given an invalid id" do
      get :show, id: 'not-here'
      expect(response).to redirect_to(projects_path)

      message = 'The project you were looking for could not be found'
      expect(flash[:alert]).to eql(message)
    end
  end
end
