class AddDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_primary
      t.string :phone_secondary
      t.decimal :donation_amount
      t.integer :city_section
      t.string :street_1
      t.string :street_2
      t.integer :level
      t.integer :buzzer_number
      t.boolean :elevator
      t.string :directions
      t.datetime :scheduled_pickup_time
      t.datetime :possible_future_pickup_time
      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
