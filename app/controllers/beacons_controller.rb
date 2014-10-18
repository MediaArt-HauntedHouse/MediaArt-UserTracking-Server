class BeaconsController < ApplicationController
  before_action :set_beacon, only: [:show, :edit, :update, :destroy]

  def index
    @beacons = Beacon.all
  end

  def show
  end

  def new
    @beacon = Beacon.new
    @beacon.uuid = 'FF2BB40C-6C0E-1801-A386-001C4DB9EE23'
  end

  def edit
  end

  def create
    @beacon = Beacon.new(beacon_params)

    respond_to do |format|
      if @beacon.save
        format.html { redirect_to @beacon, notice: 'Beacon was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @beacon.update(beacon_params)
        format.html { redirect_to @beacon, notice: 'Beacon was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @beacon.destroy
    respond_to do |format|
      format.html { redirect_to beacons_url, notice: 'Beacon was successfully destroyed.' }
    end
  end

  private
    def set_beacon
      @beacon = Beacon.find(params[:id])
    end

    def beacon_params
      params[:beacon].permit :uuid, :major, :minor, :latitude, :longitude
    end
end
