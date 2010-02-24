class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id
  belongs_to :recipient
  
  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  #named_scope :by_newest_delivery_date,  lambda{ |recipient_id| {:conditions => ["recipient_id = ?", recipient_id], :order => 'scheduled_delivery_time DESC'}}
  named_scope :by_newest_delivery_date,  lambda{ |recipient_id| {:conditions => ["recipient_id = ?", recipient_id], :order => 'scheduled_delivery_time DESC'}}
  named_scope :by_oldest_uncompleted,  {:conditions => ["state <> 3"], :order => 'scheduled_delivery_time ASC'}
  named_scope :for_date, lambda{ |a_date| {:conditions => ["scheduled_delivery_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)], :order => 'scheduled_delivery_time DESC'}}
  
  ENTERED = 0
  SCHEDULED = 1
  PARTIAL = 2
  COMPLETED = 3
  CANCELLED = 4
  
  STATES = { ENTERED => "Entered", SCHEDULED => "Scheduled", 
             PARTIAL => "Partially Done", COMPLETED => "Done", CANCELLED => "Cancelled"}
             
  # priority classifications
  CLASS_A = 1
  CLASS_B = 2
  CLASS_C = 3
  
  PRIORITIES = { CLASS_A => "A", CLASS_B => "B", CLASS_C => "C" }

# NOT used yet (may use later)
#  def total_requested_items
#    self.delivered_items.map { |sum, element| sum + element.number_requested}
#  end
  
  
end
