class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # require 'digest'
  protect_from_forgery with: :null_session

  # before_filter :authenticate
 
  # def authenticate
  #   authenticate_or_request_with_http_basic('Administration') do |username, password|
  #     md5_of_password = Digest::MD5.hexdigest(password)
  #     username == 'mediaart' && md5_of_password == 'd6cc6232b64c09b9a4f9135488538af7'
  #   end
  # end
end
