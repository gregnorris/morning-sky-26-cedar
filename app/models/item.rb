class Item < ActiveRecord::Base

  named_scope :that_are_valid,  {:conditions => ["obsolete IS NOT TRUE"]}
  named_scope :ordered_by_category, :order => "category_id ASC"
  

  ITEM_SPACER = '---------------'
  
  #--- item categories (in the future, maybe use the table I created)
  BEDS = 1
  BEDROOM = 2
  LIVING = 3
  KITCHEN = 4
  OFFICE = 5
  OTHER = 6
  
  ITEM_CATEGORIES = { BEDS => "BEDS", BEDROOM => "BEDROOM", OFFICE => "DINING", 
             KITCHEN => "KITCHEN", LIVING => "LIVING", OTHER => "OTHER"}
  #--- end of item categories ---------------------
  
  def category_string
   return Item::ITEM_CATEGORIES[self.category_id] if self.category_id
   return ""
  end
  
  def dashes_string
    ITEM_SPACER.first(ITEM_SPACER.size - self.item_code.size)
  end

  #TODO: make this ordered alphabetically within each category
  def self.items_for_select(add_or_select='select')
    the_prompt_text = add_or_select == 'select' ? "Select an item" : "Add an item"
    
    # sort by category, and have nil category items appear at the end
    #sorted_items = Item.that_are_valid.sort{ |a,b| (a.category_id && b.category_id) ? a.category_id <=> b.category_id : ( a.category_id ? -1 : 1 ) }
    # #{it.category_string[0..3]} -- 
    Item.that_are_valid.ordered_by_category.map { |it| ["#{it.item_code} #{it.dashes_string} #{it.name}", it.id] }.unshift([the_prompt_text, nil])
    
    
    #Item.all.map { |it| ["#{it.item_code} #{it.dashes_string} #{it.name}", it.id]}.unshift([the_prompt_text, nil])
  end

end
