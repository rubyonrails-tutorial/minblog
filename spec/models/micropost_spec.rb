# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "Contenu du message" }
  end

  it "devrait créer instance de micro-message avec bons attributs" do
    @user.microposts.create!(@attr)
  end

  describe "associations avec l'utilisateur" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "devrait avoir un attribut user" do
      @micropost.should respond_to(:user)
    end

    it "devrait avoir le bon utilisateur associé" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "les associations au micro-message" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "devrait avoir un attribut 'microposts'" do
      @user.should respond_to(:microposts)
    end
  end  

  describe "validations" do

    it "requiert un identifiant d'utilisateur" do
      Micropost.new(@attr).should_not be_valid
    end

    it "requiert un contenu non vide" do
      @user.microposts.build(:content => "  ").should_not be_valid
    end

    it "derait rejeter un contenu trop long" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end
  end
end
