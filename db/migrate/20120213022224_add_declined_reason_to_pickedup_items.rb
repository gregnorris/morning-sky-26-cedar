class AddDeclinedReasonToPickedupItems < ActiveRecord::Migration
  def self.up
    add_column :pickedup_items, :declined_reason, :integer
  end

  def self.down
    add_column :pickedup_items, :declined_reason
  end
end
