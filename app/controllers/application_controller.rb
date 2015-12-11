class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) << :username
  devise_parameter_sanitizer.for(:sign_up) << :avatar_url

  devise_parameter_sanitizer.for(:account_update) << :avatar_url
end

helper ApplicationHelper

protected

  def youtube_id(youtube_url)
  if youtube_url[/youtu\.be\/([^\?]*)/]
    youtube_id = $1
  else
    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
    youtube_id = $5
  end
  return youtube_id
  end


end
