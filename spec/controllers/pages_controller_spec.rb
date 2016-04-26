require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views
  
  before(:each) do
    @base_title = "Mini Blog"
  end  

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get :home
      byebug
      expect(response).should have_selector('head title',
        :text => @base_title + " | Home")
    end
  end

  describe "GET #contact" do
    it "returns http success" do
      get 'contact'
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get 'contact'
      response.should have_selector('head title',
        :text => @base_title + " | Contact")
    end

    describe "quand pas identifié" do
      before(:each) do
        get :home
      end

      it "devrait réussir" do
        response.should be_success
      end

      it "devrait avoir le bon titre" do
        response.should have_selector("title",
                                      :content => "#{@base_title} | Home")
      end
    end

    describe "quand identifié" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "devrait avoir le bon compte d'auteurs et de lecteurs" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 followers")
      end
    end
  end
  
  describe "GET #about" do
    it "devrait réussir" do
      get 'about'
      expect(response).to have_http_status(:success)
    end
 
    it "devrait avoir le bon titre" do
      get 'about'
      response.should have_selector('head title',
        :text => @base_title + " | About")
    end    
  end
end