class PickedupItem < ActiveRecord::Base
  belongs_to :donor_pickup
  belongs_to :item
  
  validates_presence_of :item_id
  
  named_scope :that_were_donated,  {:conditions => ["number_donated IS NOT NULL AND number_donated > 0"]}
  named_scope :that_were_offered,  {:conditions => ["number_offered IS NOT NULL AND number_offered > 0"]}
  
  named_scope :is_this_item,  lambda{ |the_item_id| {:conditions => ["item_id = ?", the_item_id]}}
  named_scope :ordered_by_item_category, {:include => :item, :order => "items.category_id ASC"}
  named_scope :still_to_pickup, :conditions => ["done IS NOT TRUE"]
end