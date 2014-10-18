class AddBeaconColumn < ActiveRecord::Migration
  def change
    add_column :beacons, :uuid, :string, :limit => 36
    add_column :beacons, :major, :integer
    add_column :beacons, :minor, :integer
  end
end
