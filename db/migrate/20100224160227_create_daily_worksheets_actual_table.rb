class CreateDailyWorksheetsActualTable < ActiveRecord::Migration
  def self.up
    create_table :daily_worksheets do |t|
      t.integer :daily_worksheet_id
      t.integer :worksheet_date
      t.text    :special_comments
      t.timestamps
    end
  end

  def self.down
    drop_table :daily_worksheets
  end
end
