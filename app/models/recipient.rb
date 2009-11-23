class Recipient < ActiveRecord::Base
  
  has_many :deliveries
  belongs_to :case_worker

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
