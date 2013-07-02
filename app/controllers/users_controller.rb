class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to projects_path, notice: 'You have signed up!'
    else
      flash[:alert] = 'You have not yet signed up'
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile has been updated'
    else
      flash[:alert] = 'Profile has not been updated'
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
