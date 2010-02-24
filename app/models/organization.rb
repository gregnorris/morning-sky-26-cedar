class Organization < ActiveRecord::Base
  
  has_many :case_workers
  validates_presence_of :org_short_name
  
  named_scope :name_like,  lambda{ |search_term| {:conditions => ["org_short_name LIKE :term", {:term => "%#{search_term}%"}]}}
  
  def self.items_for_select
    Organization.all.map { |it| ["#{it.org_short_name}", it.id]}
  end
  
  
  
end
