class RenameOrderToPositionInDailyDeliveries < ActiveRecord::Migration
  def self.up
    rename_column :daily_deliveries, :order, :position
  end

  def self.down
    rename_column :daily_deliveries, :position, :order
  end
end
