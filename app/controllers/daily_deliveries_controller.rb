class DailyDeliveriesController < ApplicationController

  def the_model_name;   'DailyDeliveries'; end
  def the_model_symbol; :daily_delivery;  end
  def parent_model_name; 'DailyWorksheet'; end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    {:controller => :daily_worksheets, :action => 'edit', :id => @daily_worksheet}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    {:controller => :daily_worksheets, :action => 'edit', :id => @daily_worksheet}
  end
  
  def build_the_thing
    @the_thing = @daily_worksheet.daily_deliveries.build(params[:daily_delivery])
  end
  
  
  def set_the_thing
    @the_thing = @daily_worksheet.daily_deliveries.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  

protected

  def set_objects 
    @daily_worksheet = DailyWorksheet.find(params[:daily_worksheet_id]) if params[:daily_worksheet_id]
  end
  
  def lineage
    [@daily_worksheet, @the_thing]
  end
  
end
