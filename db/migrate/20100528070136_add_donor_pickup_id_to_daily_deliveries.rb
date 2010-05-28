class AddDonorPickupIdToDailyDeliveries < ActiveRecord::Migration
  def self.up
    add_column :daily_deliveries, :donor_pickup_id, :integer
  end

  def self.down
    remove_column :daily_deliveries, :donor_pickup_id
  end
end
