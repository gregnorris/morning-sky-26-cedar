# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # authlogic stuff
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  before_filter :require_user

  
  helper_method :lineage
  
  # gets called before every action
  prepend_before_filter :set_objects

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # the default redirect for after create and update actions is the 'show' action
  def the_update_redirect; {:action => 'show', :id => @the_thing}; end
  
  def the_delete_redirect; {:action => 'index'}; end
  #def the_update_error_redirect; {:action => 'edit'}; end
  
  def set_objects
    set_the_thing
  end
  
  # ex.  if the_model_name is a Recipient, the_model_symbol = :recipient
  def build_the_thing
    @the_thing = the_model_name.constantize.new(params[the_model_symbol])
  end
  
  
  # ex. if MODEL_NAME = Recipient, then @the_thing = Recipient.find(params[:id]
  def set_the_thing
    @the_thing = the_model_name.constantize.find(params[:id]) if params[:id] && params[:id] != 'new'
  end
  
  def default_pagination_params(opts = {})
    {:page => (params[:page] || 1),  :per_page => 5}.merge(opts) # should be 50 maybe
  end
  
  # GET /recipients
  # GET /recipients.xml
  def index
    
    if (params[:search_term] || params[:city_section])
      @the_things = the_model_name.constantize.name_like(params[:search_term]).paginate(default_pagination_params) if params[:search_term]
      # search by city_section if that param is passed in (convert city_section string name to key for db lookup first)
      @the_things = the_model_name.constantize.city_section_is(params[:city_section]).paginate(default_pagination_params) if params[:city_section]
    else
      @the_things = the_model_name.constantize.all.paginate(default_pagination_params)  # no search to perform, just return all items in the table
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @the_things }
    end
  end

  # GET /recipients/1
  # GET /recipients/1.xml
  def show
    set_the_thing
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @the_thing }
    end
  end

  # GET /recipients/new
  # GET /recipients/new.xml
  def new
    @the_thing = the_model_name.constantize.new
    #build_children
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @the_thing }
    end
  end

  # GET /recipients/1/edit
  def edit
    set_the_thing
    #build_children
  end

  # POST /recipients
  # POST /recipients.xml
  def create
    build_the_thing
    
    respond_to do |format|
      if @the_thing.save
        flash[:notice] = "#{@the_thing.class.to_s} was successfully created."
        
        # redirect to the action specified by the sub-controller (ex. 'index', 'show', ect)
        format.html { redirect_to the_update_redirect  }
        format.xml  { render :xml => @the_thing, :status => :created, :location => @the_thing }
      else
        flash[:error] = @the_thing.errors.full_messages.to_sentence
        format.html { render :action => "new" }
        format.xml  { render :xml => @the_thing.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /recipients/1
  # PUT /recipients/1.xml
  def update
    set_the_thing
    
    respond_to do |format|
      # get the params symbol to get the attributes
      # ex.  if @the_thing is a Recipient, then @the_thing.class.name.downcase.to_sym = :recipient
      if @the_thing.update_attributes(params[the_model_symbol])
        flash[:notice] = "#{@the_thing.class.to_s} was successfully updated."
        
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
  
  # DELETE /recipients/1
  # DELETE /recipients/1.xml
  def destroy
    set_the_thing
    @the_thing.destroy

    respond_to do |format|
      format.html { redirect_to the_delete_redirect }
      format.xml  { head :ok }
    end
  end
  
  # authlogic stuff
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

#  def require_no_user
#    if current_user
#      store_location
#      flash[:notice] = "You must be logged out to access this page"
#      redirect_to account_url
#      return false
#    end
#  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
