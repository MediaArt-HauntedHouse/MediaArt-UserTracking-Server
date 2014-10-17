class BeaconsController < ApplicationController
  def index
    @beacons = Beacon.all
  end

  def show
    @beacon = Beacon.find params[:id]
  end

  def new
    @beacon = Beacon.new()
  end

  def create
    @beacon = Beacon.new(params)
    if @beacon.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
