class AddPriorityToDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :priority, :integer
  end

  def self.down
    remove_column :deliveries, :priority
  end
end
