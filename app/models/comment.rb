class Comment < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  
  belongs_to :user
  belongs_to :event

  validates_presence_of :body
  
end
