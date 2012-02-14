class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item
  
  validates_presence_of :item_id
  
  named_scope :donated_on_a_specific_date, lambda{ |a_date| {:conditions => ["donated_on = ?", a_date.beginning_of_day.to_s(:db)]}} # .utc.strftime("%Y-%m-%d")
  named_scope :donated_on_is_null, {:conditions => ["donated_on IS NULL"]}
  named_scope :ordered_by_item_category, {:include => :item, :order => "items.category_id ASC"}
end
