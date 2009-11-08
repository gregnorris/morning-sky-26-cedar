class ItemsController < ApplicationController
  
  def the_model_name;   'Item'; end
  def the_model_symbol; :item;  end
  
  # we want successful create and update actions to redirect back to the index
  def the_update_redirect; 'index'; end

end
