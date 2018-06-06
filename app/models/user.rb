#A user object is created for each new user
#All users saved to the same user table regardless of sign up method to normalize the user table

class User < ApplicationRecord
	has_and_belongs_to_many :events
	#has_many :artist_tags
	
	#for traditional authentication
	has_secure_password

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
		    user.provider = auth.provider
		    user.uid = auth.uid
		    user.name = auth.info.name unless user.name != nil
		    #if signed up with 3rd party, generate a random unique email and password for user
		    user.email =  SecureRandom.hex + '@example.com' unless user.email != nil
		    user.password_digest = SecureRandom.urlsafe_base64 unless user.password_digest != nil
		    user.save!
		end
	end
end
