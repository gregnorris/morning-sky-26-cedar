class AddDoneToDeliveredItems < ActiveRecord::Migration
  def self.up
    add_column :delivered_items, :done, :boolean
  end

  def self.down
    remove_column :delivered_items, :done
  end
end
