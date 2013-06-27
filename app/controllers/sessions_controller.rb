class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(name: params[:session][:name]).first

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Signed in successfully'
    else
      flash[:alert] = 'Invalid credentials'
      render action: 'new'
    end
  end
end
