class Recipient < ActiveRecord::Base
  
  has_many :deliveries

  def name
    "#{self.first_name} #{self.last_name}"
  end

end
