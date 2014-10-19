class MapController < ApplicationController
  def index
  end
  def create
    WebsocketRails[:streaming].trigger "create", params[:beacon]
    render :text => 'ok', :status => 200
  end
end
