class Resident < ActiveRecord::Base
  
  belongs_to :recipient
  
  named_scope :children,  {:conditions => "age < 18"}
  named_scope :adults,  {:conditions => "age > 17"}
  
  GENDERS = { 'M' => 'Male', 'F' => 'Female'}
  
  PARENT = 1
  CHILD = 2
  RELATIVE = 3
  ROOMMATE = 4
  OTHER = 5
  ADULT = 6
  
  
  CATEGORIES = {PARENT => 'Parent', CHILD => 'Child', ADULT => 'Adult', RELATIVE => 'Relative',  
                ROOMMATE => 'Roommate', OTHER => 'Other'}
  
end
