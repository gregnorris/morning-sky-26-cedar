class DeliveriesController < ApplicationController

  def the_model_name;   'Delivery'; end
  def the_model_symbol; :delivery;  end
  def parent_model_name; 'Recipient'; end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    {:controller => :recipients, :action => 'edit', :id => @recipient}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    {:controller => :recipients, :action => 'edit', :id => @recipient}
  end
  
  def build_the_thing
    @the_thing = @recipient.deliveries.build(params[:delivery])
  end
  
#  def build_children
#    @the_thing.delivered_items.build unless @the_thing.delivered_items.any?
#  end
  
  def set_the_thing
    delivery_id = (params[:id] && params[:id] != 'new' && @delivery.blank?) ? params[:id] : @delivery.id
    if @recipient
      @the_thing = @recipient.deliveries.find(delivery_id) if delivery_id
    else  # shouldn't usually happen, but may, if delivery is orphaned
      @the_thing = Delivery.find(delivery_id) if delivery_id
    end
  end
  
  # GET /recipients/1/delivery_sheet
  def delivery_sheet
    set_the_thing
    
    respond_to do |format|
      format.html { render :partial => 'delivery_sheet', :locals => {:delivery => @the_thing} }  # deliveries/_delivery_sheet.html.haml
      format.xml  { render :xml => @the_thing }
    end
  end
  
  def add_to_worksheet
    the_delivery_id = params[:id]
    the_worksheet_date = Date.parse(params[:the_worksheet_date])
    the_worksheet = DailyWorksheet.find_by_worksheet_date(the_worksheet_date)
  
    if the_worksheet
      the_worksheet.daily_deliveries.build(:pickup_or_delivery => 2, :position => nil, 
                                   :delivery_id => the_delivery_id, :target_date => the_worksheet_date)
    
      if the_worksheet.save!
        flash[:notice] = "Delivery # #{the_delivery_id} was added to the daily worksheet for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      else
        flash[:error] ="Failed to update daily worksheet #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      end
    else
      flash[:error] = "Delivery # #{the_delivery_id} could not be added because no daily worksheet exists for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
    end
    respond_to do |format|
      format.html {redirect_to deliveries_path}
    end
  end
  
  # items filtered by search parms (if any) -- shown in the index
  def searched_items
    # search by city_section if that param is passed in (convert city_section string name to key for db lookup first)
    if params[:city_section]
      @the_things = Delivery.city_section_is(params[:city_section]).paginate(default_pagination_params)
      return
    end
    
    @the_things = Delivery.first_name_like(params[:search_first_name]).
                          last_name_like(params[:search_last_name]).
                          address_like(params[:search_address]).
                          health_number_like(params[:search_health_number]).
                          with_state(params[:search_state]).
                          with_priority(params[:search_priority]).
                          is_pending(params[:search_pending]).
                          city_section_is(params[:search_city_section]).
                          for_delivery_date_range(params[:search_delivery_time_lowest], params[:search_delivery_time_highest]).
                          select{ |d| params[:search_item_id].blank? ? true : d.has_this_item?(params[:search_item_id].to_i)}.
                          paginate(default_pagination_params)
    
  end
  
  
protected

  def set_objects 
    recip = (params[:recipient_id] && @recipient.nil?) ? params[:recipient_id] : @recipient
    @recipient = Recipient.find(recip) if recip
  end
  
  def lineage
    [@recipient, @the_thing]
  end
  
end
