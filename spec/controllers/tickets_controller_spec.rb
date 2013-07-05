require 'spec_helper'

describe TicketsController do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, user: user) }

  context "standard users" do
    it "can not access a ticket without permission" do
      sign_in(user)

      get :show, id: ticket, project_id: project

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql('The project you were looking for could not be found')
    end
  end
end

