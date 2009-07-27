class AddItems < ActiveRecord::Migration
  def self.up
    drop_table :items
  
    create_table :items do |t|
      t.integer :item_code
      t.integer :name
      t.string :description
      t.string :icon_path
      t.string :image_path
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
