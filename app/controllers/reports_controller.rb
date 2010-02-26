class ReportsController < ApplicationController

  def the_model_name; 'Reports'; end
  
  def set_objects
     
  end

  def index
    
    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @the_things }
    end
  end
  
  def deliveries_stats
    
#    start_date = Date.parse(params[:report_start_date])
#    end_date = Date.parse(params[:report_end_date])
    
    
    respond_to do |format|
      #:locals => {:start_date => start_date, :end_date => end_date}
      format.html {render('deliveries_stats.html.haml')}
    end
    
    
  end
  
end
