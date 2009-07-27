class AddDatesToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :work_school_schedule, :string
    add_column :recipients, :donation, :decimal
    add_column :recipients, :additional_information, :string
    add_column :recipients, :intake_date, :date
    add_column :recipients, :referred_by, :string
    add_column :recipients, :next_scheduled_delivery, :datetime
  end

  def self.down
    remove_column :recipients, :work_school_schedule
    remove_column :recipients, :donation
    remove_column :recipients, :additional_information
    remove_column :recipients, :intake_date
    remove_column :recipients, :referred_by
    remove_column :recipients, :next_scheduled_delivery
  end
end
