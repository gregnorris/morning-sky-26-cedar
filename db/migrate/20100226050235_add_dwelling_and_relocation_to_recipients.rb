class AddDwellingAndRelocationToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :dwelling_type, :integer
    add_column :recipients, :medical_relocation, :boolean
    add_column :recipients, :relocation_from_reserve, :boolean
  end

  def self.down
    remove_column :recipients, :dwelling_type
    remove_column :recipients, :medical_relocation
    remove_column :recipients, :relocation_from_reserve
  end
end
