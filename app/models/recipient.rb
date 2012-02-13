class Recipient < ActiveRecord::Base
  
  has_many :deliveries, :dependent => :destroy
  has_many :residents, :dependent => :destroy
  belongs_to :case_worker
  
  # needs special code in the "reject_if" so the boolean checkbox values of '0' (false) are considered "blank".
  accepts_nested_attributes_for :residents, :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }
  
  validates_presence_of :first_name, :last_name
  
  #named_scope :name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "%#{search_term}%"}]}}
  #named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]}}
  
  named_scope :first_name_like,  lambda{ |search_term| {:conditions => ["first_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :last_name_like,  lambda{ |search_term| {:conditions => ["last_name LIKE :term", {:term => "#{search_term}%"}]} unless search_term.blank?}
  named_scope :address_like,  lambda{ |search_term| {:conditions => ["street_1 LIKE :term", {:term => "%#{search_term}%"}]} unless search_term.blank?}
  #named_scope :for_pickup_date_range,  lambda{ |date_start, date_end| {:conditions => ["scheduled_pickup_time BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.to_s(:db), Date.parse(date_end).end_of_day.to_s(:db)]} unless (date_start.blank? || date_end.blank?)}
  named_scope :with_status,  lambda{ |search_term| {:conditions => ["status = ?", search_term]} unless search_term == ''}
  #named_scope :is_pending,  lambda{ |search_term| {:conditions => ["pending = ?", search_term]} unless search_term == ''}
  #named_scope :with_priority,  lambda{ |search_term| {:conditions => ["priority = ?", search_term]} unless search_term == ''}
  named_scope :health_number_like, lambda{ |search_term| {:conditions => ["health_care_number = :term", {:term => "#{search_term}"}]} unless search_term.blank?}
  
  named_scope :city_section_is,  lambda{ |section| {:conditions => ["city_section = ?", section]} unless section.blank?}
  
  
  #named_scope :for_date, lambda{ |a_date| {:conditions => ["scheduled_pickup_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)], :order => 'scheduled_pickup_time DESC'}}

  
  
  GENDERS = { 'M' => 'Male', 'F' => 'Female'}
  
  #------------ dwelling_type constants --------------------------------
  HOUSE = 1
  TOWNHOUSE = 2
  APARTMENT = 3
  ROOM = 4
  DUPLEX = 5
  TRIPLEX = 6
  BUSINESS = 7
  CHURCH = 8
  
  DWELLINGS_LONG = {HOUSE => 'H - House', TOWNHOUSE => 'TH - Townhouse', APARTMENT => 'APT - Apartment',  
                    ROOM => 'RM - Room', DUPLEX => 'DUP - Duplex', TRIPLEX => 'TRI - Triplex', BUSINESS => 'BUS - Business', CHURCH => 'CHURCH - Church'}
  DWELLINGS = {HOUSE => 'H', TOWNHOUSE => 'TH', APARTMENT => 'APT',  
               ROOM => 'RM', DUPLEX => 'DUP', TRIPLEX => 'TRI', BUSINESS => 'BUS', CHURCH => 'CHURCH'}
  #------------ dwelling_type constants --------------------------------
  
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
  
  def spouse_string
    the_spouse = residents.the_spouse.first
    return "" unless the_spouse
    "SPOUSE: #{the_spouse.gender} (#{the_spouse.age})"
  end
  
  def other_adults_string
    adults_string = residents.other_adults.any? ? "OTHER ADULTS: " : ""
    for adult in residents.other_adults
      adults_string << "#{adult.gender} (#{adult.age}) "
    end
    adults_string
  end
  
  def boys_ages
    the_boys = residents.boys
    return "" unless the_boys
    return the_boys.map {|boy| boy.age.to_s}.join(',')
  end
  
  def girls_ages
    the_girls = residents.girls
    return "" unless the_girls
    return the_girls.map {|girl| girl.age.to_s}.join(',')
  end
  
  def has_an_aboriginal_in_household?
    self.residents.aboriginals.any?
  end
  
  def has_a_recent_immigrant_in_household?
    self.residents.recent_immigrants.any?
  end
  
  def has_a_disabled_person_in_household?
    self.residents.disabled_people.any?
  end
  
  def number_of_girls
    residents.girls ? residents.girls.size : 0
  end
  
  def number_of_boys 
    residents.boys ? residents.boys.size : 0
  end
  
end
