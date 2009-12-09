class CaseWorkersController < ApplicationController

  def the_model_name;   'CaseWorker'; end
  def the_model_symbol; :case_worker;  end
  
  # where to redirect to after a successful create or update action
  def the_update_redirect
    #return {:controller => :recipients, :action => 'show', :id => @recipient} if @recipient
    return {:action => 'index'}
  end
  
  # where to redirect to after a successful delete action
  def the_delete_redirect
    the_update_redirect
  end
  
  
protected

  # we expect this to be set, so we know which recipient we are currently editing
  def set_objects 
    @recipient = Recipient.find(params[:recipient_id]) if params[:recipient_id]
  end
  
  
end
