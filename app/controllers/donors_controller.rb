class DonorsController < ApplicationController

  def the_model_name;   'Donor'; end
  def the_model_symbol; :donor;  end
  
  def the_update_redirect
    {:controller => :donors, :action => 'edit', :id => @the_thing}
  end
  
  def add_to_worksheet
    the_donor_id = params[:id]
    the_worksheet_date = Date.parse(params[:the_worksheet_date])
    the_worksheet = DailyWorksheet.find_by_worksheet_date(the_worksheet_date)
  
    if the_worksheet
      the_worksheet.daily_deliveries.build(:pickup_or_delivery => 1, :position => nil, 
                                   :donor_id => the_donor_id, :target_date => the_worksheet_date)
    
      if the_worksheet.save!
        flash[:notice] = "Donor # #{the_donor_id} was added to the daily worksheet for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      else
        flash[:error] ="Failed to update daily worksheet #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
      end
    else
      flash[:error] = "Donor # #{the_donor_id} could not be added because no daily worksheet exists for #{the_worksheet_date.andand.strftime("%a %b %d, %Y")}"
    end
    
    respond_to do |format|
      format.html {redirect_to donors_path}
    end
  end

end
