require 'spec_helper'

describe Admin::UsersController do

  let(:user) { FactoryGirl.create(:user) }

  context 'regular users' do
    before { sign_in(user) }

    it 'can not access admin sections of the app' do
      get :index

      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql('You must be an admin to do that')
    end
  end

end
