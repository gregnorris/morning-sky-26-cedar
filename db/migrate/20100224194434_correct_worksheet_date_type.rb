class CorrectWorksheetDateType < ActiveRecord::Migration
  def self.up
    rename_column :daily_worksheets, :worksheet_date, :bad_ws_date
    add_column :daily_worksheets, :worksheet_date, :date
  end

  def self.down
    remove_column :daily_worksheets, :worksheet_date
    rename_column :daily_worksheets, :bad_ws_date, :worksheet_date
  end
end
