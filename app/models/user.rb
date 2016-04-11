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
  
  validates :name, presence: {message: "Le nom de ne dois pas etre vide."}
  validates :email, uniqueness: {message: "Cette nom doit etre unique."}

  validates :email, presence: {message: "Le email de ne dois pas etre vide."}
  validates :email, uniqueness: {message: "Cette email doit etre unique"}
end
