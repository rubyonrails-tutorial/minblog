require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  render_views

  describe "contrôle d'accès" do

    it "devrait refuser l'accès pour  'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "devrait refuser l'accès pour  'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "échec" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "ne devrait pas créer de micro-message" do
        lambda do
          post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end

      it "devrait retourner la page d'accueil" do
        post :create, :micropost => @attr
        response.should render_template('pages/home')
      end
    end

    describe "succès" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "devrait créer un micro-message" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost, :count).by(1)
      end

      it "devrait rediriger vers la page d'accueil" do
        post :create, :micropost => @attr
        response.should redirect_to(root_path)
      end

      it "devrait avoir un message flash" do
        post :create, :micropost => @attr
        flash[:success].should =~ /enregistré/i
      end
    end
  end
end