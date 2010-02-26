class AddDwellingTypeToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :dwelling_type, :integer
  end

  def self.down
    remove_column :donors, :dwelling_type
  end
end
