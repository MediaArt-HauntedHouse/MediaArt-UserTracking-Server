class AddBeaconsLocationColumn < ActiveRecord::Migration
  def change
    add_column :beacons , :latitude, :decimal, :precision => 10, :scale => 7, :null => false
    add_column :beacons , :longitude, :decimal, :precision => 10, :scale => 7, :null => false
  end
end
