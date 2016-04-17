class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def new
    @titel = "Sign up"
    @user = User.new    
  end

  def show
    @titre = @user.name
    byebug
  end  
  
  def create
    @user = User.new(user_params)
    byebug
    if @user.save
      flash[:success] = "Welcome to Mini Blog!"
      # succès d'enregistrement et redirection users/:id.
      redirect_to @user
    else
      @titre = "Sign up"
      render 'new'
    end  
  end  
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
