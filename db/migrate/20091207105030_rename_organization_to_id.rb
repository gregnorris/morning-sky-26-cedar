class RenameOrganizationToId < ActiveRecord::Migration
  def self.up
    rename_column :case_workers, :organization, :organization_id
  end

  def self.down
    rename_column :case_workers, :organization_id, :organization
  end
end
