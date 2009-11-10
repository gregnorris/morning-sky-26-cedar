class Donor < ActiveRecord::Base
  
  has_many :donor_items
  
  named_scope :name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "%#{search_term}%"}]}}
  named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]}}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def address; street_1; end
  def city_section_string; ApplicationHelper::CITY_SECTIONS[city_section]; end
  
end
