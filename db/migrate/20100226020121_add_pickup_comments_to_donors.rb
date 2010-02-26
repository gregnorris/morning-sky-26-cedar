class AddPickupCommentsToDonors < ActiveRecord::Migration
  def self.up
    add_column :donors, :pickup_comments, :string
  end

  def self.down
    remove_column :donors, :pickup_comments
  end
end
