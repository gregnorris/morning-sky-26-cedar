class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item
  
  validates_presence_of :item_id
  
  named_scope :donated_on_a_specific_date, lambda{ |a_date| {:conditions => ["donated_on = ?", a_date.to_s(:db)]}}
  named_scope :donated_on_is_null, {:conditions => ["donated_on IS NULL"]}
end
