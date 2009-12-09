class Delivery < ActiveRecord::Base
  
  has_many :delivered_items, :foreign_key => :delivery_id
  belongs_to :recipient
  
  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  named_scope :ordered_by_newest_delivery_date,  lambda{ |recipient_id| {:conditions => ["recipient_id = ?", recipient_id], :order => 'scheduled_delivery_time DESC'}}
  
  ENTERED = 0
  PARTIAL = 1
  COMPLETED = 2
  
  STATES = { ENTERED => "Entered", PARTIAL => "Partially Done", COMPLETED => "Done"}

  def total_requested_items
    self.delivered_items.map { |sum, element| sum + element.requested_items}
  end
end
