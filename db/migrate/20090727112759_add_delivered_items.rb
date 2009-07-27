class AddDeliveredItems < ActiveRecord::Migration
  def self.up
    create_table :delivered_items do |t|
      t.integer :delivery_id
      t.integer :item_id
      t.integer :number_requested
      t.integer :number_delivered
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :delivered_items
  end
end
