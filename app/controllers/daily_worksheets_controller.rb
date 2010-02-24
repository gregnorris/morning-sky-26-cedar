class DailyWorksheetsController < ApplicationController

#  def index
#    @ = Delivery.for_date(Time.now)
#    #@scheduled_pickups = 
#  end
#  
#  def reorder
#    render(:partial => "daily_delivery", :collection => @scheduled_deliveries_and_pickups)
#  end

#end

  def the_model_name;   'DailyWorksheet'; end
  def the_model_symbol; :daily_worksheet;  end
  
  def the_update_redirect
    {:controller => :daily_worksheet, :action => 'edit', :id => @the_thing}
  end
  
  def set_the_thing
    @the_thing = the_model_name.constantize.find(params[:id]) if params[:id] && params[:id] != 'new'
    # set the delivery var to the oldest delivery with a state != Done (for imbedded view use)
    # (it will be shown exploded on the recipient edit page, so it's easy to edit it)
    if @the_thing then
      @delivery = @the_thing.deliveries.any? ? @the_thing.oldest_uncompleted_delivery : nil
    end
  end
  
  # special action
  def reorder
    render(:partial => "daily_delivery", :collection => @the_thing.daily_deliveries)
  end
  
  # override new, so we can set all the daily deliveries to the ones targeted for today, by default
  def new
    @the_thing = the_model_name.constantize.new
#    Delivery.all.for_date(Time.now).each do |delivery|
#      @the_thing.daily_deliveries.build(delivery)
#    end
    
    
    
    
    
    
    @the_thing.deliveries = Time.now unless @the_thing.intake_date  # set to now by default
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @the_thing }
    end
  end
  
  # just show the map (this will be called to display in a new window; poor man's popup)
  def show_map
    render :partial => 'shared/city_section_map.html.haml'
  end
end
