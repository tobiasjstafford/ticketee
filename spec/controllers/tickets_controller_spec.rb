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

    context "with permission to view a project" do
      def cannot_create_tickets!
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql('You cannot create tickets for this project')
      end

      def cannot_edit_tickets!
        expect(response).to redirect_to project
        expect(flash[:alert]).to eql 'You cannot edit tickets for this project'
      end

      before do
        sign_in(user)
        define_permission!(user, :view, project)
      end

      it "cannot begin to create a ticket" do
        get :new, project_id: project
        cannot_create_tickets!
      end

      it "cannot actually create a ticket" do
        request['ticket'] = project.tickets.build
        post :create, project_id: project, ticket: project.tickets.build.attributes
        cannot_create_tickets!
      end

      it "cannot edit tickets" do
        get :edit, project_id: project, id: ticket
        cannot_edit_tickets!
      end

      it "cannot update tickets" do
        patch :update, project_id: project, id: ticket, ticket: ticket.attributes
        cannot_edit_tickets!
      end
    end
  end
end

