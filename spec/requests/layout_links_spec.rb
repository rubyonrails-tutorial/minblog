require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  
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
end