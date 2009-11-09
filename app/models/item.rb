class Item < ActiveRecord::Base

  ITEM_SPACER = '-------'
  
  def dashes_string
    ITEM_SPACER.first(ITEM_SPACER.size - self.item_code.size)
  end

  def self.items_for_select
    Item.all.map { |it| ["#{it.item_code} #{it.dashes_string} #{it.name}", it.id]}
  end

end
