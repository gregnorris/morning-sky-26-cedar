class DeliveriesController < ApplicationController

  def the_model_name;   'Delivery'; end
  def the_model_symbol; :delivery;  end
  def parent_model_name; 'Recipient'; end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    {:controller => :recipients, :action => 'show', :id => @recipient}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    {:controller => :recipients, :action => 'show', :id => @recipient}
  end
  
  def build_the_thing
    @the_thing = @recipient.deliveries.build(params[:delivery])
  end
  
#  def build_children
#    @the_thing.delivered_items.build unless @the_thing.delivered_items.any?
#  end
  
  def set_the_thing
    @the_thing = @recipient.deliveries.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  
  

  
protected

  def set_objects 
    @recipient = Recipient.find(params[:recipient_id]) if params[:recipient_id]
  end
  
  def lineage
    [@recipient, @the_thing]
  end
  
end
