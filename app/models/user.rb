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

class User < ActiveRecord::Base
  # Les "attr_accessible" en ete supprimer de puis Rails 4.0 et remplacer de puis les Strong parameters.
  # attr_accessible :name, :email
  
  validates_presence_of :name, message: "Le nom de ne dois pas etre vide."
  validates_uniqueness_of :name, message: "Cette nom doit etre unique."
  validates_length_of :name, maximum: 20, message: "La longueur maximale du nom est 20 lettre."
  
  validates_presence_of :email, message: "Le email de ne dois pas etre vide."
  validates_uniqueness_of :email, message: "Cette email doit etre unique"
end
