class Recipient < ActiveRecord::Base
  
  has_many :deliveries, :dependent => :destroy
  has_many :residents, :dependent => :destroy
  belongs_to :case_worker
  
  # needs special code in the "reject_if" so the boolean checkbox values of '0' (false) are considered "blank".
  accepts_nested_attributes_for :residents, :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }
  
  validates_presence_of :first_name, :last_name
  
  named_scope :name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "%#{search_term}%"}]}}
  named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]}}
  
  GENDERS = { 'M' => 'Male', 'F' => 'Female'}
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def phones_formatted
    "#{phone_primary} (primary) " + (phone_secondary.blank? ? "" : " / #{phone_secondary} (secondary)")
  end
  
  def address; street_1; end
  def city_section_string; ApplicationHelper::CITY_SECTIONS[city_section]; end
  
  def oldest_uncompleted_delivery
    deliveries.by_oldest_uncompleted.first
  end
  
end
