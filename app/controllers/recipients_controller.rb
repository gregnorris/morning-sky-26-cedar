class RecipientsController < ApplicationController

  def the_model_name;   'Recipient'; end
  def the_model_symbol; :recipient;  end
  
  def the_update_redirect
    {:controller => :recipients, :action => 'edit', :id => @the_thing}
  end
  
  def set_the_thing
    @the_thing = the_model_name.constantize.find(params[:id]) if params[:id] && params[:id] != 'new'
    # set the delivery var to the latest delivery (for imbedded view use)
    if @the_thing then
      @delivery = @the_thing.deliveries.any? ? @the_thing.deliveries.last : nil
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
end
