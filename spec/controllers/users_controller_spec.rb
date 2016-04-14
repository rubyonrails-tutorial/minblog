require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET #show" do

    before(:each) do
      @user = Factory(:user)
    end

    it "devrait réussir" do
      get 'show', :id => @user
      response.should be_success
    end

    it "devrait trouver le bon utilisateur" do
      get 'show', :id => @user
      assigns(:user).should == @user
    end
  end  
  
  describe "GET #new" do
    it "devrait réussir" do
      get 'new'
      expect(response).to have_http_status(:success)
    end

    it "devrait avoir le titre adéquat" do
      get 'new'
      expect(response).should have_selector("head title", :content => "Sign up")
    end
  end  

end