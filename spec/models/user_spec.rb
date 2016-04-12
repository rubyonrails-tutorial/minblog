# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe User do

    before(:each) do
      @attr = { :name => "Example User", :email => "user@example.com" }
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
      uniqueness_email_user = User.create!(@attr)
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
  end
end
