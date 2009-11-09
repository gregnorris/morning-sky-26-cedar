class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id
  
  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => :all_blank

  
end