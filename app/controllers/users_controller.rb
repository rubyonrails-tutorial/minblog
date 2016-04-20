class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def new
    @titel = "Sign up"
    @user = User.new    
  end

  def show
    @titel = @user.name
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Mini Blog!"
      # succès d'enregistrement et redirection users/:id.
      redirect_to @user
    else
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end  
  end

  def edit
    @titel = "Edit user"
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
