require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "sign up" do

    describe "failure" do
      it "ne devrait pas créer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Name",          :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Password confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "successful" do
      it "devrait créer un nouvel utilisateurr" do
        lambda do
          visit signup_path
          fill_in "Name", :with => "Example User"
          fill_in "Email", :with => "user@example.com"
          fill_in "Password", :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
            :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end    
  end
end