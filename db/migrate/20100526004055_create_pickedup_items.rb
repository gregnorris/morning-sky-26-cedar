class CreatePickedupItems < ActiveRecord::Migration
  def self.up
    create_table :pickedup_items do |t|
      t.integer :donor_pickup_id
      t.integer :item_id
      t.integer :number_offered
      t.integer :number_donated
      t.string  :comments
      t.boolean :done
      t.timestamps
    end
    
    add_index :pickedup_items, :donor_pickup_id
    add_index :pickedup_items, :item_id
  end

  def self.down
    drop_table :pickedup_items
  end
end
