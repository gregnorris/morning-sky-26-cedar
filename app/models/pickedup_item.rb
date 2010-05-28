class PickedupItem < ActiveRecord::Base
  belongs_to :donor_pickup
  belongs_to :item
  
  validates_presence_of :item_id
  
  named_scope :that_were_donated,  {:conditions => ["number_donated IS NOT NULL AND number_donated > 0"]}

end