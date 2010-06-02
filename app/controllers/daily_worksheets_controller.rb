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
    {:controller => :daily_worksheets, :action => 'edit', :id => @the_thing}
  end
  
  def set_the_thing
    @the_thing = the_model_name.constantize.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  
  # special action
  def reorder
  
    # GGG not implemented yet -- and out of date
    render(:partial => "daily_delivery", :collection => @the_thing.daily_deliveries)
  end
  
  # override new, so we can set all the daily deliveries to the ones targeted for today, by default
  def new
    @the_thing = the_model_name.constantize.new  # DailyWorksheet.new
    
    @the_thing.worksheet_date = Date.parse(params[:the_worksheet_date]) # was Time.now.to_date
    
    d_count = 0
    
    # get all donor pickups that are schedules for this date
    DonorPickup.for_date(@the_thing.worksheet_date).each do |donor_pickup|
      d_count = d_count + 1
      @the_thing.daily_deliveries.build(:pickup_or_delivery => 1, :donor_pickup_id => donor_pickup.id, 
                                          :position => d_count, :target_date =>  @the_thing.worksheet_date)
    end 
    
    # get all deliveries that are scheduled for this date
    Delivery.for_date(@the_thing.worksheet_date).each do |delivery|
      d_count = d_count + 1
      @the_thing.daily_deliveries.build(:pickup_or_delivery => 2, :position => d_count, 
                                          :delivery_id => delivery.id, :target_date =>  @the_thing.worksheet_date)
    end
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @the_thing }
    end
  end
  
  # override 'update' so we check for any other donors or deliveries that have been updated to 
  # be scheduled for TODAY
  def update
    set_the_thing
    
    #raise params[:daily_worksheet].changes.inspect  #[:daily_deliveries_attributes]
    
    respond_to do |format|
      # get the params symbol to get the attributes
      # ex.  if @the_thing is a Recipient, then @the_thing.class.name.downcase.to_sym = :recipient
      if @the_thing.update_attributes(params[the_model_symbol])
        flash[:notice] = "#{@the_thing.class.to_s} was successfully updated."
        
#        @the_thing.special_comments = "booooo"
#        @the_thing.daily_deliveries.each do |dd|
#          unless dd.changes.blank?
#            dd.changes.has_key?(:donor_id)
#          end
#        end
        
        
        # redirect to the action specified by the sub-controller (ex. 'index', 'show', ect)
        format.html { redirect_to the_update_redirect  }
        format.xml  { head :ok }
      else
        flash[:error] = @the_thing.errors.full_messages.to_sentence
        format.html { render :action => "edit" }
        format.xml  { render :xml => @the_thing.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def print_worksheet
    set_the_thing
    
    respond_to do |format|
      format.html { render :partial => 'worksheet', :locals => {:worksheet => @the_thing} }
      format.xml  { render :xml => @the_thing }
    end
  end
  
  
end
