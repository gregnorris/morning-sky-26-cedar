class Item < ActiveRecord::Base

  ITEM_SPACER = '-------'
  
  def dashes_string
    ITEM_SPACER.first(ITEM_SPACER.size - self.item_code.size)
  end

  #TODO: make this ordered alphabetically within each category
  def self.items_for_select(add_or_select='select')
    the_prompt_text = add_or_select == 'select' ? "Select an item" : "Add an item"
    Item.all.map { |it| ["#{it.item_code} #{it.dashes_string} #{it.name}", it.id]}.unshift([the_prompt_text, nil])
  end

end
