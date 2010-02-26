class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item
  
  validates_presence_of :item_id

end
