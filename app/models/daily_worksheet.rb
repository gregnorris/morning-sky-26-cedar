class DailyWorksheet < ActiveRecord::Base

  has_many :daily_deliveries, :order => "position", :dependent => :destroy
  accepts_nested_attributes_for :daily_deliveries, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
  # this works now, I think
  named_scope :for_date, lambda{ |a_date| {:conditions => ["worksheet_date = ?", a_date.beginning_of_day.to_s(:db)]}} # .utc.strftime("%Y-%m-%d")
  
  #before_save :assign_target
  
#  def assign_target
#    raise self.changes.inspect
#  end
  
end
