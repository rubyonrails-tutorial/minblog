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
end
