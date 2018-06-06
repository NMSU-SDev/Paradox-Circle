#responsible for creating a new Tag record and appropriate association to artist

class TagsController < ApplicationController
	def create
		@tag = Tag.new(tag_params)
		@tag.save!
		#logger.debug "params: #{params.inspect}"

		artist = Artist.find_by(id: params[:tag][:artistId])
		artist.tags << @tag
		artist.save!
		redirect_to artist
		flash[:success]="Tag added"
	end

	def increaseTagCount
		#now uses HMT artist_tags table instead of HABTM artists_tags
		#I asked stack overflow about updating count and my problem was solved in 2 minutes. 
		logger.debug "parameters: #{params.inspect}"
		artistToUpdate = Artist.find(params[:ids][0])
		tagToUpdate = Tag.find(params[:ids][1])
		artistTagToUpdate = artistToUpdate.artist_tags.find_by_tag_id(tagToUpdate.id)
		artistTagToUpdate.update(tag_count: artistTagToUpdate.tag_count + 1)
		redirect_to artistToUpdate
		flash[:success]= "Tag " + tagToUpdate.name + " added to " + artistToUpdate.name + "."
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def new
		@tag = Tag.new(:name)
	end


end
