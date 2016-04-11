class UsersController < ApplicationController
  def new
    @titel = "Sign up"
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email)
  end  
end
