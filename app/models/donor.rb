class Donor < ActiveRecord::Base
  
  has_many :donor_items

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
