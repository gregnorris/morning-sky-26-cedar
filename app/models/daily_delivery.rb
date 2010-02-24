class DailyDelivery < ActiveRecord::Base

  belongs_to :recipient  # don't use directly -- use "target" instead
  belongs_to :donor      # don't use directly -- use "target" instead
  belongs_to :delivery
  belongs_to :daily_worksheet
  acts_as_list :scope => :daily_worksheet
  
  named_scope :for_date,  lambda{ |a_date| {:conditions => ["target_date = :term", {:term => "%#{a_date}%"}]}}
  #named_scope :in_order, {:order => 'order ASC']}

  PICKUP = 1
  DELIVERY = 2
  
  TARGET_TYPES = {PICKUP => 'PU', DELIVERY => 'DEL'}
  
  # return target person for this worksheet delivery entry, which will be either a donor or recipient
  def target
    return self.donor if self.pickup_or_delivery == PICKUP
    return self.delivery.recipient if self.pickup_or_delivery == DELIVERY

  end
  

  # string formatted list of items and number
  def items_list
    return self.donor.donor_items.map{|it| " #{it.item.item_code} (#{it.number_donated}) "}.join("/") if (self.pickup_or_delivery == PICKUP) && self.donor
    return self.delivery.delivered_items.map{|it| " #{it.item.item_code} (#{it.number_requested}) "}.join("/") if (self.pickup_or_delivery == DELIVERY) and self.delivery
  end

end
