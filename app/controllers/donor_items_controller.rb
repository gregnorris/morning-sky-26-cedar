class DonorItemsController < ApplicationController

  def the_model_name;   'DonorItem'; end
  def the_model_symbol; :donor_item;  end
  def parent_model_name; 'Donor'; end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    {:controller => :donors, :action => 'edit', :id => @donor}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    {:controller => :donors, :action => 'edit', :id => @donor}
  end
  
  def build_the_thing
    @the_thing = @donor.donor_items.build(params[:donor_item])
  end
  

  
  def set_the_thing
    @the_thing = @donor.donor_items.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  
  

protected

  def set_objects 
    @donor = Donor.find(params[:donor_id]) if params[:donor_id]
  end
  
  def lineage
    [@donor, @the_thing]
  end
  
end
