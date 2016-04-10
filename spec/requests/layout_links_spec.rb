require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  
  # Test des routages
  it "devrait trouver une page Home à '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "devrait trouver une page Contact a '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "devrait trouver une page About a '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "devrait trouver une page Help a '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "devrait avoir une page pour signup a '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  # Vérifient que les routages conduisent effectivement sur les bonnes pages 
  it "devrait avoir le bon lien sur le layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up"
    response.should have_selector('title', :content => "Sign up")
  end  
end