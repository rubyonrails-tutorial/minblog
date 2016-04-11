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

    it "devrait exiger un nom"
  end
end
