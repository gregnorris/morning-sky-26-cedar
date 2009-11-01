class ChangeItemsCodeAndNameType < ActiveRecord::Migration
  def self.up
    change_column :items, :item_code, :string
    change_column :items, :name, :string
  end

  def self.down
    change_column :items, :item_code, :integer
    change_column :items, :name, :integer
  end
end
