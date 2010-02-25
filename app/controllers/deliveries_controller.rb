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
    @the_thing = @recipient.deliveries.find(delivery_id) if delivery_id
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
  
  
protected

  def set_objects 
    recip = (params[:recipient_id] && @reciptient.nil?) ? params[:recipient_id] : @recipient
    @recipient = Recipient.find(recip) if recip
  end
  
  def lineage
    [@recipient, @the_thing]
  end
  
end
