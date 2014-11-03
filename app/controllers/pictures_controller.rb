class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :destroy]

  def index
    @pictures = Picture.all.order('created_at DESC')
  end

  def show
  end

  def view
    @pictures = Picture.last(60)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        WebsocketRails[:streaming].trigger "newpicture", @picture
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
    end
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params[:picture].permit :body
    end
end
