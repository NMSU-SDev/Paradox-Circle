class ArtistTag < ApplicationRecord
  belongs_to :artist
  belongs_to :tag
  
end
