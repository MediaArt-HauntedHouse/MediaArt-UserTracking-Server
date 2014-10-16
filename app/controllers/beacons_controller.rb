class BeaconsController < ApplicationController
  def index
    @beacons = Beacon.all
  end
end
