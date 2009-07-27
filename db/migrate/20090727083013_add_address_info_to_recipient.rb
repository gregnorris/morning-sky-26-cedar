class AddAddressInfoToRecipient < ActiveRecord::Migration
  def self.up
    add_column :recipients, :city_section, :integer
    add_column :recipients, :street_1, :string
    add_column :recipients, :street_2, :string
    add_column :recipients, :level, :integer
    add_column :recipients, :buzzer_number, :integer
    add_column :recipients, :elevator, :boolean
    add_column :recipients, :directions, :string
    add_column :recipients, :move_in_date, :date
    add_column :recipients, :previous_address, :string
  end

  def self.down
    remove_column :recipients, :city_section
    remove_column :recipients, :street_1
    remove_column :recipients, :street_2
    remove_column :recipients, :level
    remove_column :recipients, :buzzer_number
    remove_column :recipients, :elevator
    remove_column :recipients, :directions
    remove_column :recipients, :move_in_date
    remove_column :recipients, :previous_address
  end
end
