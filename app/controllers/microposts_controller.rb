class MicropostsController < ApplicationController
  before_action :authenticate, only: [:create, :destroy]

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
end