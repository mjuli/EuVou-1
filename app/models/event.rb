class Event < ActiveRecord::Base
	resourcify
  include Authority::Abilities
	
	belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  has_one :address
	mount_uploader :images, ImageUploader
  
  accepts_nested_attributes_for :address, allow_destroy: true

	validates_presence_of :category
  
  def self.search(search)
    if search
      joins("INNER JOIN 'categories' ON 'categories'.id = category_id").where('lower(title) LIKE ? or categories.name LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
    else
      all
    end
  end
  
end

