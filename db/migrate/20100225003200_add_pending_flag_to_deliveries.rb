class AddPendingFlagToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :pending, :boolean
  end

  def self.down
    remove_column :deliveries, :pending
  end
end
