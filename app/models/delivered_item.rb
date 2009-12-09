class DeliveredItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :item
  
  validates_presence_of :item_id

end
