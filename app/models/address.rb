class Address < ActiveRecord::Base
  belongs_to :event

  validates_presence_of :location
end
