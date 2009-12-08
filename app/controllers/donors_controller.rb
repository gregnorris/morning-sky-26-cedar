class DonorsController < ApplicationController

  def the_model_name;   'Donor'; end
  def the_model_symbol; :donor;  end
  
  def the_update_redirect
    {:controller => :donors, :action => 'edit', :id => @the_thing}
  end

end
