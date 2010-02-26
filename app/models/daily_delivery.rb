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
  
  
  def visit_notes 
   return target.pickup_comments if (self.pickup_or_delivery == PICKUP) && self.donor
   return delivery.comments if (self.pickup_or_delivery == DELIVERY) and self.delivery
  end
  
  def priority
     return target.priority if (self.pickup_or_delivery == PICKUP) && self.donor
     return delivery.priority if (self.pickup_or_delivery == DELIVERY) and self.delivery
  end
  

  # string formatted list of items and number
  def items_list
    return self.donor.donor_items.reject{|it| it.done?}.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_donated}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>") if (self.pickup_or_delivery == PICKUP) && self.donor
    return self.delivery.delivered_items.reject{|it| it.done?}.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_requested}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>") if (self.pickup_or_delivery == DELIVERY) and self.delivery
  end

end
