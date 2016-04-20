class UsersController < ApplicationController
  before_action :authenticate, only: [:index, :edit, :updat]
  before_action :correct_user, only: [:edit, :updat]  
  before_action :set_user, only: [:show]

  def index
    @titel = "Users list"
    @users = User.paginate(:page => params[:page])
  end
  
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

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Update profile #{@user.name}."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end  

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
