class DailyDelivery < ActiveRecord::Base

  has_one :recipient  # don't use directly -- use "target" instead
  has_one :donor      # don't use directly -- use "target" instead
  has_one :delivery
  
  named_scope :for_date,  lambda{ |a_date| {:conditions => ["target_date = :term", {:term => "%#{a_date}%"}]}}
  #named_scope :in_order, {:order => 'order ASC']}

  PICKUP = 1
  DELIVERY = 2
  
  TARGET_TYPES = {PICKUP => 'PU', DELIVERY => 'DEL'}
  
  # return target person for this worksheet delivery entry, which will be either a donor or recipient
  def target
    (self.pickup_or_delivery == PICKUP) ? self.donor : self.recipient
  end
  

  # string formatted list of items and number
  def items_list
    (self.pickup_or_delivery == PICKUP) ?
            self.donor.donor_items.map{|it| "it.item.item_code (#{it.number_donated}) / "} : 
            self.delivery.delivered_items.map{|it| "it.item.item_code (#{it.number_requested}) / "}
  end

end
