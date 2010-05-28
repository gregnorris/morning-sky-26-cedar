class AddConvertedToPickupIdToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :converted_to_pickup_id, :integer
    
    add_index :donors, :converted_to_pickup_id
  end

  def self.down
    remove_column :donors, :converted_to_pickup_id
  end
end
