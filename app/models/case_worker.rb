class CaseWorker < ActiveRecord::Base

  has_many :recipients
  belongs_to :organization

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.items_for_select
    CaseWorker.all.map { |it| ["#{it.full_name} - #{it.organization.andand.org_short_name}", it.id]}.unshift(['none', nil])
  end

end
