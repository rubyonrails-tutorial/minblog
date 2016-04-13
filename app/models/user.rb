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

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates_presence_of :name, message: "Le nom ne dois pas etre vide."
  validates_uniqueness_of :name, message: "Le nom doit etre unique."
  validates_length_of :name, maximum: 20, message: "La longueur maximale du nom est 20 lettre."
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_presence_of :email, message: "Le email ne dois pas etre vide."
  validates_format_of :email, :with => VALID_EMAIL_REGEX, message: "email doit respecter le formt RFC 2822."  
  validates_uniqueness_of :email, case_sensitive: false, message: "Cette email doit etre unique"
  
  # Crée automatique l'attribut virtuel 'password_confirmation'.
  validates :password,
    :presence     => true,
    :confirmation => true,
    :length       => { :within => 6..40 }
end
