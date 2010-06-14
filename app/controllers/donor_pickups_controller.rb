class DonorPickupsController < ApplicationController

  def the_model_name;   'DonorPickup'; end
  def the_model_symbol; :donor_pickup;  end
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
    @the_thing = @donor.donor_pickups.build(params[:donor_pickup])
  end
  
#  def build_children
#    @the_thing.delivered_items.build unless @the_thing.delivered_items.any?
#  end
  
  def set_the_thing
    donor_pickup_id = (params[:id] && params[:id] != 'new' && @donor_pickup.blank?) ? params[:id] : @donor_pickup.id
    if @donor
      @the_thing = @donor.donor_pickups.find(donor_pickup_id) if donor_pickup_id
    else  # shouldn't usually happen, but may, if delivery is orphaned
      @the_thing = DonorPickup.find(donor_pickup_id) if donor_pickup_id
    end
  end
  
  
  def add_to_worksheet
    the_donor_pickup_id = params[:id]
    the_worksheet_date = Date.parse(params[:the_worksheet_date])
    the_worksheet = DailyWorksheet.find_by_worksheet_date(the_worksheet_date)
    
    if the_worksheet
      the_worksheet.daily_deliveries.build(:pickup_or_delivery => 1, :position => nil, 
                                           :donor_pickup_id => the_donor_pickup_id, :target_date => the_worksheet_date)
      
      if the_worksheet.save!
        flash[:notice] = "Pickup # #{the_donor_pickup_id} was added to the daily worksheet for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      else
        flash[:error] ="Failed to update daily worksheet #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      end
    else
      flash[:error] = "Pickup # #{the_donor_pickup_id} could not be added because no daily worksheet exists for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
    end
    respond_to do |format|
      format.html {redirect_to donor_pickups_path}
    end
  end
  
  # items filtered by search parms (if any) -- shown in the index
  def searched_items
    # search by city_section if that param is passed in (convert city_section string name to key for db lookup first)
    #if params[:city_section]
    #  @the_things = DonorPickup.city_section_is(params[:city_section]).paginate(default_pagination_params)
    #  return
    #end
    
    
    @the_things = DonorPickup.first_name_like(params[:search_first_name]).
                          last_name_like(params[:search_last_name]).
                          address_like(params[:search_address]).
                          with_state(params[:search_state]).
                          with_priority(params[:search_priority]).
                          is_pending(params[:search_pending]).
                          city_section_is(params[:search_city_section]).
                          for_pickup_date_range(params[:search_pickup_time_lowest], params[:search_pickup_time_highest]).
                          select{ |dp| params[:search_item_id].blank? ? true : dp.has_this_item?(params[:search_item_id].to_i)}.
                          paginate(default_pagination_params)
                          
  end
  
  
protected

  def set_objects 
    the_donor = (params[:donor_id] && @donor.nil?) ? params[:donor_id] : @donor
    @donor = Donor.find(the_donor) if the_donor
  end
  
  def lineage
    [@donor, @the_thing]
  end
  
end
