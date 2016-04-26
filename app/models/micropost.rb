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

class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope -> { order('created_at DESC') }
  
  # Retourne les micro-messages des utilisateurs suivi par un utilisateur donné.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  
  private

  # Retourne une condition SQL pour les utilisateurs suivis par un utilisateur donné.
  # Nous incluons aussi les propres micro-messages de l'utilisateur.
  def self.followed_by(user)
    followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
    where("user_id IN (#{followed_ids}) OR user_id = :user_id",
      { :user_id => user })
  end
end
