class AddExtraFlagsToRecipient < ActiveRecord::Migration
  def self.up
    add_column :recipients, :aboriginal, :boolean
    add_column :recipients, :disabled, :boolean
    add_column :recipients, :gender, :string, :limiit => 1
    add_column :recipients, :bed_bugs, :boolean
    add_column :recipients, :date_of_birth, :date
    add_column :recipients, :age, :integer
  end

  def self.down
    remove_column :recipients, :aboriginal
    remove_column :recipients, :disabled
    remove_column :recipients, :gender
    remove_column :recipients, :bed_bugs
    remove_column :recipients, :date_of_birth
    remove_column :recipients, :age
  end
end
