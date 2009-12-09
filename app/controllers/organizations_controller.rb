class OrganizationsController < ApplicationController

  def the_model_name;   'Organization'; end
  def the_model_symbol; :organization;  end
  
  def the_update_redirect
    {:action => 'index'}
  end

end
