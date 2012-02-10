class Donor < ActiveRecord::Base
  
  has_many :donor_pickups, :dependent => :destroy
  
  # old original way
  has_many :donor_items, :dependent => :destroy
  accepts_nested_attributes_for :donor_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }
  has_many :daily_deliveries, :dependent => :destroy
  
  named_scope :first_name_like,  lambda{ |search_term| {:conditions => ["first_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :last_name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :address_like,  lambda{ |search_term| {:conditions => ["street_1 LIKE :term", {:term => "%#{search_term}%"}]} unless search_term.blank?}
  named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]} unless section.blank?}
  
  #named_scope :for_pickup_date_range,  lambda{ |date_start, date_end| {:conditions => ["scheduled_pickup_time BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.utc.to_s(:db), Date.parse(date_end).end_of_day.utc.to_s(:db)]} unless (date_start.blank? || date_end.blank?)}
  #named_scope :with_state,  lambda{ |search_term| {:conditions => ["state = ?", search_term]} unless search_term == ''}
  #named_scope :is_pending,  lambda{ |search_term| {:conditions => ["pending = ?", search_term]} unless search_term == ''}
  #named_scope :with_priority,  lambda{ |search_term| {:conditions => ["priority = ?", search_term]} unless search_term == ''}
  #named_scope :was_pickedup,  {:conditions => ["state = 2 OR state = 3"]}
  
  #named_scope :for_date, lambda{ |a_date| {:conditions => ["scheduled_pickup_time BETWEEN ? AND ?", a_date.beginning_of_day.utc.to_s(:db), a_date.end_of_day.utc.to_s(:db)], :order => 'scheduled_pickup_time DESC'}}
  
  # priority classifications
  CLASS_A = 1
  CLASS_B = 2
  
  PRIORITIES = { CLASS_A => "A", CLASS_B => "B" }
  
  ENTERED = 0
  SCHEDULED = 1
  PARTIAL = 2
  COMPLETED = 3
  CANCELLED = 4
  NOT_DONE = 5
  
  STATES = { ENTERED => "Entered", SCHEDULED => "Scheduled", 
             PARTIAL => "Partially Done", NOT_DONE => "Not Done", COMPLETED => "Done", CANCELLED => "Cancelled"}
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def phones_formatted
    "#{phone_primary} (primary) " + (phone_secondary.blank? ? "" : " / #{phone_secondary} (secondary)")
  end
  
  def address; street_1; end
  def city_section_string; ApplicationHelper::CITY_SECTIONS[city_section]; end
  
  # string formatted list of items and number
  # TODO: remove after depricated items on donor are removed from donor view
  def items_list
    return self.donor_items.map{|it| " #{it.item.andand.item_code} (#{it.number_donated}) "}.join("/")
  end
  
  # use ordered_by_item_category instead
  #def sorted_donor_items
  #  self.donor_items.sort{ |a,b| a.andand.item.category_string <=> b.andand.item.category_string }
  #end
  
  def self.total_households_that_donated_items(from_date, to_date)
    return DonorPickup.picked_up_between(from_date, to_date).was_pickedup.compact.map{|dp| dp.donor}.uniq.size
  end
  
end
