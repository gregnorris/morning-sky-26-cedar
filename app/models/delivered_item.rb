class DeliveredItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :item

end
