class DailyWorksheet < ActiveRecord::Base

  has_many :daily_deliveries, :order => "position"
  accepts_nested_attributes_for :daily_deliveries, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  named_scope :for_date, lambda{ |a_date| {:conditions => ["worksheet_date = :term", {:term => "%#{a_date}%"}]}}
  
  #before_save :assign_target
  
#  def assign_target
#    raise self.changes.inspect
#  end
  
end
