class AddLatestCallAtToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :latest_call_at, :datetime
  end

  def self.down
    remove_column :deliveries, :latest_call_at
  end
end
