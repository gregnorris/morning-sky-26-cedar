class RemoveBogusIdFromDailyWorksheets < ActiveRecord::Migration
  def self.up
    remove_column :daily_worksheets, :daily_worksheet_id
  end

  def self.down
    add_column :daily_worksheets, :daily_worksheet_id, :integer
  end
end
