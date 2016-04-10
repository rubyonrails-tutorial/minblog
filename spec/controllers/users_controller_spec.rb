require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET #new" do
    it "devrait réussir" do
      get 'signup'
      expect(response).to have_http_status(:success)
    end

    it "devrait avoir le titre adéquat" do
      get 'signup'
      expect(response).should have_selector("title", :content => "Sign up")
    end
  end  

end