class UsersController < ApplicationController
  def new
    @titel = "Sign up"
    @user = User.new    
  end

  def show
    @user = User.find(params[:id])
    @titre = @user.name
  end  
  
  def create
    @user = User.new(params[:user])    
    if @user.save
      # Traite un succès d'enregistrement.
    else
      @titre = "Inscription"
      render 'new'
    end  
  end  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
