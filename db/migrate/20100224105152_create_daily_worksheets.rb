class CreateDailyWorksheets < ActiveRecord::Migration
  def self.up
    create_table :daily_deliveries do |t|
      t.integer :daily_worksheet_id
      t.integer :pickup_or_delivery
      t.integer :recipient_id
      t.integer :donor_id
      t.integer :order
      t.integer :code
      t.integer :delivery_id
      t.date    :target_date
      t.timestamps
    end
  end

  def self.down
    drop_table :daily_deliveries
  end
end
