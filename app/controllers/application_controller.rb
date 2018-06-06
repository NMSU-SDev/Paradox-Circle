class ApplicationController < ActionController::Base
	include SessionsHelper
	protect_from_forgery
  before_action :store_history
	protected

	def current_user
  		@current_user ||= User.find_by(id: session[:user_id])
  end
  	
  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    log_out
    session[:user_id] = user.id
  end

  #Confirms a logged in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  #stores the last 5 visited artist pages
  def store_history
    session[:history] ||= []
    session[:history].delete_at(0) if session[:history].size >= 5
    #only store urls for artist pages and no duplicates
    session[:history] << request.url if request.url.include? "artist" and session[:history].exclude?(request.url)
  end
end
