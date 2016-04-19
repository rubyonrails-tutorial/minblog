require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  
  # Test des routages
  it "devrait trouver une page Home à '/'" do
    get '/'
    response.should have_selector('head title', :content => "Home")
  end

  it "devrait trouver une page Contact a '/contact'" do
    get '/contact'
    response.should have_selector('head title', :content => "Contact")
  end

  it "devrait trouver une page About a '/about'" do
    get '/about'
    response.should have_selector('head title', :content => "About")
  end

  it "devrait trouver une page Help a '/help'" do
    get '/help'
    response.should have_selector('head title', :content => "Help")
  end
  
  it "devrait avoir une page pour signup a '/signup'" do
    get '/signup'
    response.should have_selector('head title', :content => "Sign up")
  end

  # Vérifient que les routages conduisent effectivement sur les bonnes pages 
  it "devrait avoir le bon lien sur le layout" do
    visit root_path
    click_link "About"
    response.should have_selector('head title', :content => "About")
    click_link "Help"
    response.should have_selector('head title', :content => "Help")
    click_link "Contact"
    response.should have_selector('head title', :content => "Contact")
    click_link "Home"
    response.should have_selector('head title', :content => "Home")
    click_link "Sign up"
    response.should have_selector('head title', :content => "Sign up")
  end

  describe "quand pas identifié" do
    it "doit avoir un lien de connexion" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
        :content => "Sign in")
    end
  end

  describe "quand identifié" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in "Password", :with => @user.password
      click_button
    end

    it "devrait avoir un lien de déconnxion" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
        :content => "Sign out")
    end

    it "devrait avoir un lien vers le profil" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
        :content => "Profile")
    end
  end
end