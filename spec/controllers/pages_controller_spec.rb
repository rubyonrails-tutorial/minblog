require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views
  
#  before(:all) do
#    @base_titre = "Mini Blog"
#  end  

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get 'home'
      response.should have_selector("title",
        :content => "Mini Blog" + " | Home")
    end
  end

  describe "GET #contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
    
    it "devrait avoir le bon titre" do
      get 'home'
      response.should have_selector("title",
        :content => "Mini Blog" + " | Contact")
    end    
  end
  
  describe "GET #about" do
    it "devrait réussir" do
      get 'about'
      response.should be_success
    end
 
    it "devrait avoir le bon titre" do
      get 'about'
      response.should have_selector("title",
        :content => "Mini Blog" + " | About")
    end    
  end
end