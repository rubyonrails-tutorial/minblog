class UsersController < ApplicationController
  before_action :authenticate, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]  
  before_action :set_user, only: [:show, :following, :followers]
  before_action :admin_user, only: [:destroy]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def new
    @title = "Sign up"
    @user = User.new    
  end

  def show
    @title = @user.name    
    @microposts = @user.microposts.paginate(:page => params[:page])
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.deliver_registration_confirmation(@user)
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
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Update profile #{@user.name}."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleting."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end  
end
