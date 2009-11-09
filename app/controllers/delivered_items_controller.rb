class DeliveredItemsController < ApplicationController

  def the_model_name;   'DeliveredItem'; end
  def the_model_symbol; :delivered_item;  end
  def parent_model_name; 'Delivery'; end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    {:controller => :deliveries, :action => 'edit', :id => @delivery}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    {:controller => :deliveries, :action => 'edit', :id => @delivery}
  end
  
  def build_the_thing
    @the_thing = @delivery.delivered_items.build(params[:delivered_item])
  end
  

  
  def set_the_thing
    @the_thing = @delivery.delivered_items.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  
  

protected

  def set_objects 
    @recipient = Recipient.find(params[:recipient_id]) if params[:recipient_id]
    @delivery = Delivery.find(params[:delivery_id]) if params[:delivery_id]
  end
  
  def lineage
    [@recipient, @delivery, @the_thing]
  end
  
end
