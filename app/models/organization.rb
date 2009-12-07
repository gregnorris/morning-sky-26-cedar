class Organization < ActiveRecord::Base
  
  has_many :case_workers
  
  def self.items_for_select
    Organization.all.map { |it| ["#{it.org_short_name}", it.id]}
  end
  
  
  
end
