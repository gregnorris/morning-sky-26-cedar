class AddTimestampsToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :created_at, :datetime
    add_column :recipients, :updated_at, :datetime
  end

  def self.down
    remove_column :recipients, :created_at
    remove_column :recipients, :updated_at
  end
end
