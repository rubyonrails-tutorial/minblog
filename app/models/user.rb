class User < ActiveRecord::Base
  # Les "attr_accessible" en ete supprimer de puis Rails 4.0 et remplacer de puis les Strong parameters.
  # attr_accessible :name, :email
end
