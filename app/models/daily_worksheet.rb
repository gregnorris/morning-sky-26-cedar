class DailyWorksheet < ActiveRecord::Base

  has_many :daily_deliveries
  
  named_scope :for_date,  lambda{ |a_date| {:conditions => ["worksheet_date = :term", {:term => "%#{a_date}%"}]}}

  
