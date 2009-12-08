class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id
  belongs_to :recipient
  
  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }

  
  ENTERED = 0
  PARTIAL = 1
  COMPLETED = 2
  
  STATES = { ENTERED => "Entered", PARTIAL => "Partially Done", COMPLETED => "Done"}

  
end
