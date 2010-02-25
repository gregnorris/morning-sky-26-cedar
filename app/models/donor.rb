class Donor < ActiveRecord::Base
  
  has_many :donor_items, :dependent => :destroy
  accepts_nested_attributes_for :donor_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  has_many :daily_deliveries, :dependent => :destroy
  
  named_scope :name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "%#{search_term}%"}]}}
  named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]}}
  named_scope :for_date, lambda{ |a_date| {:conditions => ["scheduled_pickup_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)], :order => 'scheduled_pickup_time DESC'}}
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def phones_formatted
    "#{phone_primary} (primary) " + (phone_secondary.blank? ? "" : " / #{phone_secondary} (secondary)")
  end
  
  def address; street_1; end
  def city_section_string; ApplicationHelper::CITY_SECTIONS[city_section]; end
  
  # string formatted list of items and number
  def items_list
    return self.donor_items.map{|it| " #{it.item.andand.item_code} (#{it.number_donated}) "}.join("/")
  end
  
end
