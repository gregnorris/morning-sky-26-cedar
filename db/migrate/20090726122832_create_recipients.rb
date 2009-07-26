class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |r|
      r.column :first_name, :string
      r.column :last_name, :string
      r.column :address_id, :integer
      r.column :phone_primary, :string
      r.column :phone_secondary, :string
      r.column :email, :string
      r.column :previous_address_id, :integer
      r.column :health_care_number, :integer
      r.column :status, :boolean
      r.column :case_worker_id, :integer
      r.column :bedrooms, :integer
      r.column :number_of_adults, :integer
      r.column :number_of_children, :integer
      r.column :comments, :string
      
      
    end
  end

  def self.down
    drop_table :recipients
  end
end
