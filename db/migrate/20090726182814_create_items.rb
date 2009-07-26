class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :category
      t.string :title
      t.string :description
      t.integer :warehouse_section
      t.date :date_recieved
      t.date :date_given

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
