class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id, :dependent => :destroy
  belongs_to :recipient
  has_many :daily_deliveries, :dependent => :destroy
  
  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }
  
  
  named_scope :first_name_like,  lambda{ |search_term| {:include => :recipient, :conditions => ["recipients.first_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :last_name_like,  lambda{ |search_term| {:include => :recipient, :conditions => ["recipients.last_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :address_like,  lambda{ |search_term| {:include => :recipient, :conditions => ["recipients.street_1 LIKE :term", {:term => "%#{search_term}%"}]} unless search_term.blank?}
  named_scope :health_number_like, lambda{ |search_term| {:include => :recipient, :conditions => ["recipients.health_care_number = :term", {:term => "#{search_term}"}]} unless search_term.blank?}
  
  named_scope :for_delivery_date_range,  lambda{ |date_start, date_end| {:conditions => ["scheduled_delivery_time BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.to_s(:db), Date.parse(date_end).end_of_day.to_s(:db)]} unless (date_start.blank? || date_end.blank?)}
  named_scope :with_state,  lambda{ |search_term| {:conditions => ["state = ?", search_term]} unless search_term == ''}
  named_scope :is_pending,  lambda{ |search_term| {:conditions => ["pending = ?", search_term]} unless search_term == ''}
  named_scope :with_priority,  lambda{ |search_term| {:conditions => ["priority = ?", search_term]} unless search_term == ''}
  
  named_scope :city_section_is,  lambda{ |section| {:include => :recipient, :conditions => ["recipients.city_section = ?", section]} unless section.blank?}
  
  named_scope :was_delivered_to,  {:conditions => ["state = 2 OR state = 3"]}
  named_scope :not_yet_delivered,  {:conditions => ["state <> 2 AND state <> 3"]}
  
  named_scope :by_newest_delivery_date,  lambda{ |recipient_id| {:conditions => ["recipient_id = ?", recipient_id], :order => 'scheduled_delivery_time DESC'}}
  named_scope :by_oldest_uncompleted,  {:conditions => ["state <> 3 AND state <> 4"], :order => 'scheduled_delivery_time ASC'}
  named_scope :for_date, lambda{ |a_date| {:conditions => ["scheduled_delivery_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)], :order => 'scheduled_delivery_time DESC'}}
  
  ENTERED = 0
  SCHEDULED = 1
  PARTIAL = 2
  COMPLETED = 3
  CANCELLED = 4
  NOT_DONE = 5
  
  STATES = { SCHEDULED => "Scheduled", ENTERED => "Entered", 
             PARTIAL => "Partially Done", NOT_DONE => "Not Done", COMPLETED => "Completed", CANCELLED => "Cancelled"}
             
  # priority classifications
  CLASS_A = 1
  CLASS_B = 2
  CLASS_C = 3
  
  PRIORITIES = { CLASS_A => "A", CLASS_B => "B", CLASS_C => "C" }

# NOT used yet (may use later)
#  def total_requested_items
#    self.delivered_items.map { |sum, element| sum + element.number_requested}
#  end
  
  # string formatted list of items and number
  def items_list
    return self.delivered_items.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_requested}] "}.join("/")
  end
  
#  def self.total_people_served(from_date, to_date)
#    return total_households_served(from_date, to_date).
#  end
  
  def self.total_households_served(from_date, to_date)
    return Delivery.for_delivery_date_range(from_date, to_date).was_delivered_to.map{|del| del.recipient}.compact.uniq
  end
  
  def self.total_households_requesting(from_date, to_date)
    return Delivery.for_delivery_date_range(from_date, to_date).not_yet_delivered.map{|del| del.recipient}.compact.uniq
  end
  
  
#  
#  def self.total_people_served(from_date, to_date)
#    
#  end
#  
#  def self.total_people_served(from_date, to_date)
#    
#  end
  
  def has_this_item?(item_id)
    item_id.blank? ? true : self.delivered_items.map(&:item_id).include?(item_id)
  end
  
end
