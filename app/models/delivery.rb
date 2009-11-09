class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id
  
  #accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => :all_blank
  
  PARTIAL = 0
  DONE = 1
  
  STATES = { PARTIAL => "Partial", DONE => "Done"}

  
end
