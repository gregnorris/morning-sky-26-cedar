class AddCaseNumberToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :case_number, :string
  end

  def self.down
    remove_column :recipients, :case_number
  end
end
