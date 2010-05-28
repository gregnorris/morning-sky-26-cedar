class CreateDonorPickups < ActiveRecord::Migration
  def self.up
    create_table :donor_pickups do |t|
      t.integer  :donor_id
      t.datetime :call_recieved_at
      t.datetime :scheduled_pickup_time
      t.datetime :visited_on
      t.datetime :pickedup_on
      t.string  :visit_initialed_by, :limit => 8
      t.string  :pickup_initialed_by, :limit => 8
      t.integer :state
      t.integer :priority
      t.boolean :pending
      t.string :comments
      t.timestamps
    end
    
    add_index :donor_pickups, :donor_id
  end

  def self.down
    drop_table :donor_pickups
  end
end
