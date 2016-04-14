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

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
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
  
  before_save :encrypt_password

  # Retour true si le mot de passe correspond.
  def has_password?(password_soumis)
    # Compare encrypted_password avec la version cryptée de password_soumis.
    encrypted_password == encrypt(password_soumis)
  end  
  
  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end  
end
