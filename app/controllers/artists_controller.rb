class ArtistsController < ApplicationController
	#method for returning search results
	def index
		@search_term = params[:query]
		@artists = Artist.search(@search_term,"artists")
		@artisttags = Artist.search(@search_term,"tags")
	end
	def show
		@artist = Artist.find(params[:id])
		@tag = @artist.tags.build
	end
	#update method for updating tags. Not used anymore
  	def artist_params
		params.require(:tag).permit(:name)
	end
	

end
#comment to test pushing to fork