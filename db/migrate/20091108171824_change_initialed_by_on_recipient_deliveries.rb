class ChangeInitialedByOnRecipientDeliveries < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :initialed_by_2, :string
  end

  def self.down
    remove_column :deliveries, :initialed_by_2
  end
end
