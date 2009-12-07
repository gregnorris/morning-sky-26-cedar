class CreateTableOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :org_short_name
      t.string :org_description
      t.integer :state

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
