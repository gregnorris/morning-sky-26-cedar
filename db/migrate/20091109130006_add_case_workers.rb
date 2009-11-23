class AddCaseWorkers < ActiveRecord::Migration
  def self.up
    create_table :case_workers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :organization
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :case_workers
  end
end
