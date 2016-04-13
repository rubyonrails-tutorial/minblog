# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe User do

    before(:each) do
      @attr = { 
        :name => "Example User",
        :email => "user@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
      }
    end

    it "devrait créer une nouvelle instance dotée des attributs valides" do
      User.create!(@attr)
    end
    

    it "devrait exiger un name" do
      bad_guy = User.new(@attr.merge(:name => ""))
      bad_guy.should_not be_valid
    end    
    
    it "devrait exige une adresse email" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
    end
    
    it "devrait valider unicite de name et email" do
      # Place un utilisateur avec un email donné dans la BD.
      User.create!(@attr)
      uniqueness_email_user = User.new(@attr)
      uniqueness_email_user.should_not be_valid
    end
 
    it "devrait rejeter les noms trop longs" do
      long_nom = "a" * 21
      long_nom_user = User.new(@attr.merge(:name => long_nom))
      long_nom_user.should_not be_valid
    end
    
    it "devrait accepter une adresse email valide" do
      adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      adresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end

    it "devrait rejeter une adresse email invalide" do
      adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      adresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end

    it "devrait rejeter une adresse email invalide meme avec le no case_sensitive" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      
      other_name_and_case_sensitive_email = @attr.merge(:name => @attr[:name]+"_2")
      user_with_duplicate_email = User.new(other_name_and_case_sensitive_email)
      user_with_duplicate_email.should_not be_valid
    end
    
    
    describe "password validations" do

      it "devrait exiger un mot de passe" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end

      it "devrait exiger une confirmation du mot de passe qui correspond" do
        User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
      end

      it "devrait rejeter les mots de passe (trop) courts" do
        short = "a" * 5
        hash = @attr.merge(:password => short, :password_confirmation => short)
        User.new(hash).should_not be_valid
      end

      it "devrait rejeter les (trop) longs mots de passe" do
        long = "a" * 41
        hash = @attr.merge(:password => long, :password_confirmation => long)
        User.new(hash).should_not be_valid
      end
    end    
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "devrait avoir un attribut mot de passe crypté" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "devrait définir le mot de passe crypté" do
      @user.encrypted_password.should_not be_blank
    end    
  end  
end
