class AddStateToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :state, :integer
  end

  def self.down
    remove_column :deliveries, :state
  end
end
