class AddDonorItems < ActiveRecord::Migration
  def self.up
    create_table :donor_items do |t|
      t.integer :donor_id
      t.integer :item_id
      t.integer :number_donated
      t.date :donated_on
      t.string :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :donor_items
  end
end
