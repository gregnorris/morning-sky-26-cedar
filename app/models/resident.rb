class Resident < ActiveRecord::Base
  
  belongs_to :recipient
  
  named_scope :young_people,  {:conditions => "age < 18"}
  named_scope :adults,  {:conditions => "age > 17"}
  
  named_scope :zero_to_fourteen,  {:conditions => "age < 15"}
  named_scope :fifteen_to_thirty,  {:conditions => "age > 14 AND age < 31"}
  named_scope :thirtyone_to_sixtyfour,  {:conditions => "age > 30 AND age < 65"}
  named_scope :sixtyfive_plus,  {:conditions => "age > 64"}
  named_scope :with_no_age,  {:conditions => "age IS NULL"}
  
  named_scope :males,  {:conditions => "gender = 'M'"}
  named_scope :females,  {:conditions => "gender = 'F'"}
  named_scope :aboriginals,  {:conditions => "aboriginal = TRUE"}
  named_scope :recent_immigrants,  {:conditions => "recent_immigrant = TRUE"}
  named_scope :not_aboriginal_or_recent_immigrants,  {:conditions => "recent_immigrant = FALSE AND aboriginal = FALSE"}
  named_scope :disabled_people,  {:conditions => "disabled = TRUE"}
  named_scope :not_parents,  {:conditions => "category <> 1 AND category <> 2"}
  named_scope :parents,  {:conditions => "category = 1"}
  named_scope :children,  {:conditions => "category = 2"}
  named_scope :girls,  {:conditions => "category = 2 AND gender = 'F'"}
  named_scope :boys,  {:conditions => "category = 2 AND gender = 'M'"}
  named_scope :the_recipient,  {:conditions => "is_recipient = true"}
  named_scope :the_spouse, {:conditions => "is_recipient = false AND category = 1"}  # is not the recipient, but is a parent
  named_scope :other_adults, {:conditions => "category <> 1 AND category <> 2 AND is_recipient = false"} # everyone except parents and children
  
  
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
