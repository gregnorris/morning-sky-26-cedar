class RecipientsController < ApplicationController

  def the_model_name;   'Recipient'; end
  def the_model_symbol; :recipient;  end
  
  def the_update_redirect
    {:controller => :recipients, :action => 'edit', :id => @the_thing}
  end
  
  def set_the_thing
    @the_thing = the_model_name.constantize.find(params[:id]) if params[:id] && params[:id] != 'new'
    # set the delivery var to the oldest delivery with a state != Done (for imbedded view use)
    # (it will be shown exploded on the recipient edit page, so it's easy to edit it)
    if @the_thing then
      @delivery = @the_thing.deliveries.any? ? @the_thing.oldest_uncompleted_delivery : nil
    end
  end
  
  # override new, so we can set intake_date to Time.now by defautl
  def new
    @the_thing = the_model_name.constantize.new
    @the_thing.intake_date = Time.now unless @the_thing.intake_date  # set to now by default
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @the_thing }
    end
  end
  
  # just show the map (this will be called to display in a new window; poor man's popup)
  def show_map
    render :partial => 'shared/city_section_map.html.haml'
  end
  
  # items filtered by search parms (if any) -- shown in the index
  def searched_items
    # search by city_section if that param is passed in (convert city_section string name to key for db lookup first)
    if params[:city_section]
      @the_things = Recipient.city_section_is(params[:city_section]).paginate(default_pagination_params)
      return
    end
    
    @the_things = Recipient.first_name_like(params[:search_first_name]).
                          last_name_like(params[:search_last_name]).
                          address_like(params[:search_address]).
                          health_number_like(params[:search_health_number]).
                          city_section_is(params[:search_city_section]).
                          paginate(default_pagination_params)
    
  end
  
end
