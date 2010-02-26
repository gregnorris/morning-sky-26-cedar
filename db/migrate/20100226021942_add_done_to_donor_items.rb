class AddDoneToDonorItems < ActiveRecord::Migration
  def self.up
    add_column :donor_items, :done, :boolean
  end

  def self.down
    remove_column :donor_items, :done
  end
end
