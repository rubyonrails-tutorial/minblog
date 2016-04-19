require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views
  
  describe "GET #new" do
    it "devrait réussir" do
      get :new
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get :new
      response.should have_selector("titre", :content => "Sign in")
    end
  end

end
