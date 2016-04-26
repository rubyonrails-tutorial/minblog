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
#  salt               :string
#  admin              :boolean          default("f")
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, maximum: 25
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates_presence_of :email
  validates_format_of :email, :with => VALID_EMAIL_REGEX #RFC 2822.  
  validates_uniqueness_of :email, case_sensitive: false
  
  # Crée automatique l'attribut virtuel 'password_confirmation'.
  validates :password,
    :presence     => true,
    :confirmation => true,
    :length       => { :within => 6..40 }
  
  before_save :encrypt_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # Retour true si le mot de passe correspond.
  def has_password?(password_soumis)
    # Compare encrypted_password avec la version cryptée de password_soumis.
    encrypted_password == encrypt(password_soumis)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def feed
    Micropost.from_users_followed_by(self)
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
