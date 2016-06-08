class Event < ActiveRecord::Base
	resourcify
  include Authority::Abilities
	
	belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  has_one :address
	mount_uploader :image, ImageUploader

  has_many :eu_vous, foreign_key: :attended_event_id
  has_many :attendees, through: :eu_vous
  
  has_many :reports, foreign_key: :reported_event_id
  has_many :reportees, through: :reports
  
  accepts_nested_attributes_for :address, allow_destroy: true

	validates_presence_of :category, :title, :user
  
  def self.search(search)
    if search
      joins("INNER JOIN 'categories' ON 'categories'.id = category_id").where('lower(title) LIKE ? or categories.name LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
    else
      all
    end
  end
  
end

