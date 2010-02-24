class CorrectWorksheetDateType < ActiveRecord::Migration
  def self.up
    change_column :daily_worksheets, :worksheet_date, :date
  end

  def self.down
    change_column :daily_worksheets, :worksheet_date, :integer
  end
end
