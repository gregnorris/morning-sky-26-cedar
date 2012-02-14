class PickedupItem < ActiveRecord::Base
  belongs_to :donor_pickup
  belongs_to :item
  
  validates_presence_of :item_id
  
  named_scope :that_were_donated,  {:conditions => ["number_donated IS NOT NULL AND number_donated > 0"]}
  named_scope :that_were_offered,  {:conditions => ["number_offered IS NOT NULL AND number_offered > 0"]}
  
  named_scope :is_this_item,  lambda{ |the_item_id| {:conditions => ["item_id = ?", the_item_id]}}
  named_scope :ordered_by_item_category, {:include => :item, :order => "items.category_id ASC"}
  named_scope :still_to_pickup, :conditions => ["done IS NOT TRUE"]
  
  
  PET_HAIR = 1
  NEEDS_CLEANING = 2
  NEEDS_REPAIR = 3
  TOO_HEAVY = 4
  WORN_OUT = 5
  
  
  DECLINED_REASONS = { PET_HAIR => "Pet's Hair", NEEDS_CLEANING => "Needs Cleaning",
                       NEEDS_REPAIR => "Needs Repair", TOO_HEAVY => "Quite Heavy", 
                       WORN_OUT => "Worn-out" }
  
end