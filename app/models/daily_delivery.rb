class DailyDelivery < ActiveRecord::Base

  belongs_to :recipient   # don't use directly -- use "target" instead
  belongs_to :donor  # don't use directly -- use "target" instead
  belongs_to :donor_pickup
  belongs_to :delivery
  belongs_to :daily_worksheet
  acts_as_list :scope => :daily_worksheet
  
  # target_date isn't being set in the daily_delivery
  #named_scope :for_date,  lambda{ |a_date| {:conditions => ["target_date = :term", {:term => "%#{a_date}%"}]}}
  #named_scope :in_order, {:order => 'order ASC']}
  
  PICKUP = 1
  DELIVERY = 2
  
  TARGET_TYPES = {PICKUP => 'PU', DELIVERY => 'DEL'}
  
  # return target person for this worksheet delivery entry, which will be either a donor or recipient
  def target
    # accomodate for old daily_deliveries with only donor associated
    return (self.donor_pickup ? self.donor_pickup.donor : self.donor) if self.pickup_or_delivery == PICKUP
    return self.delivery.recipient if self.pickup_or_delivery == DELIVERY && self.delivery
  end
  
  
  def visit_notes
   return donor_pickup.comments if ((self.pickup_or_delivery == PICKUP) && self.donor_pickup)
   return donor.donor_pickups.andand.first.andand.comments if ((self.pickup_or_delivery == PICKUP) && self.donor)
   return delivery.comments if ((self.pickup_or_delivery == DELIVERY) && self.delivery)
  end
  
  def priority
     return donor_pickup.priority if (self.pickup_or_delivery == PICKUP) && self.donor_pickup
     return donor.donor_pickups.andand.first.andand.priority if (self.pickup_or_delivery == PICKUP) && self.donor
     return delivery.priority if (self.pickup_or_delivery == DELIVERY) and self.delivery
  end
  
  
  # string formatted list of items and number
  def items_list
    #return self.donor.donor_items.reject{|it| it.done?}.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_donated}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>") if (self.pickup_or_delivery == PICKUP) && self.donor
    if (self.pickup_or_delivery == PICKUP)
      the_pickup = (self.donor_pickup ? self.donor_pickup : self.donor.andand.donor_pickups.andand.first)
      return '' unless the_pickup
      
      return "" unless self.daily_worksheet.andand.worksheet_date
      
      # show items we've already picked up, if the current date is newer than the date of this "DailyDelivery"
      # TODO: make sure this date comparison works properly
      items_to_show = ((Time.now.beginning_of_day > Time.parse(self.daily_worksheet.worksheet_date.to_s)) ? the_pickup.pickedup_items_list : the_pickup.offered_items_list)
      return items_to_show
      #return items_to_show.reject{|it| it.done?}.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_offered}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>")
    elsif ((self.pickup_or_delivery == DELIVERY) and self.delivery)
      # was delivered_items.reject{|it| it.done?}
      return self.delivery.delivered_items.still_to_deliver.ordered_by_item_category.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_requested}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>")
    end
  end

end
