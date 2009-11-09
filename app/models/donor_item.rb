class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item

end
