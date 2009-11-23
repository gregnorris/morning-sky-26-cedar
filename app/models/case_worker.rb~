class CaseWorker < ActiveRecord::Base

  has_many :recipients

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.items_for_select
    CaseWorker.all.map { |it| ["#{it.full_name} - #{it.organization}", it.id]}
  end

end
