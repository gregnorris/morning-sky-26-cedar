class AddIsRecipientToResidents < ActiveRecord::Migration
  def self.up
    add_column :residents, :is_recipient, :boolean, :default => false
  end

  def self.down
    remove_column :residents, :is_recipient
  end
end
