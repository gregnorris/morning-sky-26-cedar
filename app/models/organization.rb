class Organization < ActiveRecord::Base
  
  has_many :case_workers
  validates_presence_of :org_short_name
  
  def self.items_for_select
    Organization.all.map { |it| ["#{it.org_short_name}", it.id]}
  end
  
  
  
end
