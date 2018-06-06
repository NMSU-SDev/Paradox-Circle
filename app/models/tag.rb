class Tag < ApplicationRecord
	has_many :artist_tags
	has_many :artists, through: :artist_tags
	validates :name, presence: true, length: { maximum: 20 }

	
end
