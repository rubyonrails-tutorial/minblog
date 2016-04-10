require 'rails_helper'

RSpec.describe "LayoutLinks", type: :request do
  
  it "devrait trouver une page Home à '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "devrait trouver une page Contact at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an À Propos page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "devrait trouver une page Iade à '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
end