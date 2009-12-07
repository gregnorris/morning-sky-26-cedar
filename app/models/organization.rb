class Organization < ActiveRecord::Base
  
  has_many :case_workers
  
end
