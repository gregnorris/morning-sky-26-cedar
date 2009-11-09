class Item < ActiveRecord::Base


  def self.items_for_select
    Item.all.map { |it| [it.name, it.id]}
  end

end
