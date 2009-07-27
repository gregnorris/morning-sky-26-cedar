class AddRecipientDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer  :recipient_id
      t.datetime :call_recieved_at
      t.datetime :scheduled_delivery_time
      t.datetime :visited_on_1
      t.datetime :visited_on_2
      t.datetime :delivered_on
      t.string  :initialed_by
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
