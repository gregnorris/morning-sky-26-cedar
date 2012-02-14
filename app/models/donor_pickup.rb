class DonorPickup < ActiveRecord::Base
  
  belongs_to :donor
  has_many :daily_deliveries, :dependent => :destroy
  
  has_many :pickedup_items, :foreign_key => :donor_pickup_id, :dependent => :destroy
  accepts_nested_attributes_for :pickedup_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }
  
  
  named_scope :first_name_like,  lambda{ |search_term| {:include => :donor, :conditions => ["donors.first_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :last_name_like,  lambda{ |search_term| {:include => :donor, :conditions => ["donors.last_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :address_like,  lambda{ |search_term| {:include => :donor, :conditions => ["donors.street_1 LIKE :term", {:term => "%#{search_term}%"}]} unless search_term.blank?}
  
  named_scope :for_pickup_date_range,  lambda{ |date_start, date_end| {:conditions => ["donor_pickups.scheduled_pickup_time BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.to_s(:db), Date.parse(date_end).end_of_day.to_s(:db)]} unless (date_start.blank? || date_end.blank?)}
  named_scope :picked_up_between,  lambda{ |date_start, date_end| {:conditions => ["donor_pickups.pickedup_on BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.to_s(:db), Date.parse(date_end).end_of_day.to_s(:db)]} unless (date_start.blank? || date_end.blank?)}
  
  named_scope :with_state,  lambda{ |search_term| {:conditions => ["donor_pickups.state = ?", search_term]} unless search_term == ''}
  named_scope :is_pending,  lambda{ |search_term| {:conditions => ["donor_pickups.pending = ?", search_term]} unless search_term == ''}
  named_scope :with_priority,  lambda{ |search_term| {:conditions => ["donor_pickups.priority = ?", search_term]} unless search_term == ''}
  
  named_scope :city_section_is,  lambda{ |section| {:include => :donor, :conditions => ["donors.city_section = ?", section]} unless section.blank?}
  
  named_scope :was_pickedup,  {:conditions => ["donor_pickups.state = 2 OR donor_pickups.state = 3"]}
  named_scope :not_pickedup_yet,  {:conditions => ["donor_pickups.state <> 2 AND donor_pickups.state <> 3"]}
  
  named_scope :for_date, lambda{ |a_date| {:conditions => ["donor_pickups.scheduled_pickup_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)], :order => 'scheduled_pickup_time DESC'}}
  
  # this only returns the items that match the item;  we want to find the pickup that has that item, but still see all its items
  #named_scope :for_this_item,  lambda{ |the_item_id| {:include => :pickedup_items, :conditions => ["pickedup_items.item_id = ?", the_item_id]} unless the_item_id.blank?}
  
  ENTERED = 0
  SCHEDULED = 1
  PARTIAL = 2
  COMPLETED = 3
  CANCELLED = 4
  NOT_DONE = 5
  
  
  STATES = { ENTERED => "Entered", SCHEDULED => "Scheduled", 
             PARTIAL => "Partially Done", NOT_DONE => "Not Done", COMPLETED => "Completed", CANCELLED => "Cancelled"}
             
  # priority classifications
  CLASS_A = 1
  CLASS_B = 2
  CLASS_C = 3
  
  PRIORITIES = { CLASS_A => "A", CLASS_B => "B", CLASS_C => "C" }

#  def total_pickedup_items
#    self.pickuped_items.that_were_donated.size
#  end
  
  # ggg Modified to make the list sorted by Item Category
  def items_list
    return self.pickedup_items.ordered_by_item_category.map{|it| 
      " #{it.andand.item.andand.item_code} [#{it.number_donated}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")
      }.join("/")
  end
  
  # string formatted list of items and number
  def items_list_gg_old
    return self.pickedup_items.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_donated}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("/")
  end
  
  # all items that have been offered, but have not been picked-up  << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>")
  def offered_items_list
    return self.pickedup_items.that_were_offered.still_to_pickup.ordered_by_item_category.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_offered}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>")
  end
  
  def pickedup_items_list
    return self.pickedup_items.that_were_donated.ordered_by_item_category.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_donated}] " << (it.comments.blank? ? "" : "(#{it.comments}) ")}.join("<b>/</b>")
  end
  
  def has_this_item?(item_id)
    item_id.blank? ? true : self.pickedup_items.map(&:item_id).include?(item_id)
  end
  
  
  #------------------ special import --------------------------------------------------------------
  # Special function used one time only to convert the donor pickup information from being on the 
  # donor, to be in the donor_pickups table in a similar way a recipient has many deliveries
  def self.convert_to_donor_pickups
    return  # nevef run this again
    
    Donor.all.each do |the_d|
      
      different_donation_dates = the_d.donor_items.map{|di| di.donated_on}.uniq
      
      # for each uniqe date that some items were donated, create a DonorPickup
      different_donation_dates.each do |individual_pickup_date|
        
        new_d_pickup = fill_pickup_from_donor(the_d, individual_pickup_date ? individual_pickup_date : the_d.scheduled_pickup_time)
        
        new_d_pickup.save!
        
        # save the new id of the DonorPickup we've created, so we know exactly where we copied
        # the pickup data to, during the conversion process.
        # NOTE: yes I know for the case of multiple pickups, this will be the id of the DonorPickup
        # we created last.
        the_d.converted_to_pickup_id = new_d_pickup.id
        the_d.save!
        
        # for each of the items that were donated on this date, create a PickedupItem
        items_donated_on_this_date = the_d.donor_items.donated_on_a_specific_date(individual_pickup_date) if individual_pickup_date
        items_donated_on_this_date = the_d.donor_items.donated_on_is_null unless individual_pickup_date
        
        items_donated_on_this_date.each do |an_item|
          p_item = PickedupItem.new
          p_item.donor_pickup_id = new_d_pickup.id
          p_item.item_id = an_item.item_id
          p_item.number_offered = an_item.number_donated  # same as donated, since this didn't exists before
          p_item.number_donated = an_item.number_donated
          p_item.done = an_item.done
          p_item.comments = an_item.comments
          p_item.created_at = an_item.created_at
          p_item.updated_at = an_item.updated_at
          
          p_item.save!
          
        end
      end
      
      # if there were no items for the pickup (ie. cancelled, etc, we still want to create a DonorPickup)
      unless different_donation_dates.any?
        new_d_pickup = fill_pickup_from_donor(the_d, nil)  # no pickup date, or visted_on, since nothing was picked up
        
        new_d_pickup.save!
        
        the_d.converted_to_pickup_id = new_d_pickup.id
        the_d.save!
      end
     
    end
    return true  # so we don't see all the records modified, in the console
  end
  
  def self.fill_pickup_from_donor(the_d, individual_pickup_date)
    new_d_pickup = DonorPickup.new
    new_d_pickup.donor_id = the_d.id
    new_d_pickup.call_recieved_at = the_d.created_at  # just set it to donor created time
    new_d_pickup.scheduled_pickup_time = the_d.scheduled_pickup_time
    new_d_pickup.visited_on = individual_pickup_date  # the date these donor_items were donated on
    new_d_pickup.pickedup_on = individual_pickup_date  # the date these donor_items were donated on
    #new_d_pickup.visit_intialed_by = nil
    #new_d_pickup.pickup_initialed_by = nil
    new_d_pickup.state = the_d.state
    new_d_pickup.priority = the_d.priority
    new_d_pickup.pending = the_d.pending
    new_d_pickup.comments = the_d.pickup_comments
    new_d_pickup.created_at = the_d.created_at
    
    return new_d_pickup
  end
  
  def self.special_d_test
    Donor.all.each do |the_d|
      
      different_donation_dates = the_d.donor_items.map{|di| di.donated_on}.uniq
      puts "#{the_d.id}: #{the_d.first_name}" if (different_donation_dates.size > 1)
    end
    return true
  end
  
#8: CATHY
#9: DEJONG
#35: KAREN
#38: GRANT
#63: CHRISTINE
#98: PAT
#99: GERALDINE
#104: CHERYL
#111: BOB
#143: MARIA
#147: BARBARA
#152: JOHN
#153: PATTI & DON
#156: SITA
#171: MRS
#186: KRIS
#202: NANCY
#204: CHRISTINE
#217: SANDY
#218: MARY
#224: MELISSA
#225: SUZANNE
#227: SHARON
#238: MCC
#239: JOANNE
#246: RENEE
#252: MRS
#260: MYRNA
#271: KELLY
#281: KATHY
#284: RAJ & AMRIT
#288: CHRISTINA
#294: MICHELLE
#297: DENNIS & BECKY
#299: SAAID
#309: KEITH OR JENNIFER
#320: E
#336: LEANN
#339: SARAH

  #------------------ special import --------------------------------------------------------------
  
end
