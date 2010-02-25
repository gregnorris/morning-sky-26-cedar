class AddStatusBedBugsAndClassToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :pending, :boolean
    add_column :donors, :priority, :integer
    add_column :donors, :bed_bugs, :boolean
    add_column :donors, :state, :integer
  end

  def self.down
    remove_column :donors, :state
    remove_column :donors, :bed_bugs
    remove_column :donors, :priority
    remove_column :donors, :pending
  end
end
