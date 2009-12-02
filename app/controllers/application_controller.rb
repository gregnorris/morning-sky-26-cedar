# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  helper_method :lineage
  
  # gets called before every action
  prepend_before_filter :set_objects

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # the default redirect for after create and update actions is the 'show' action
  def the_update_redirect; {:action => 'show', :id => @the_thing}; end
  
  def the_delete_redirect; {:action => 'index'}; end
  
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
  
  # GET /recipients
  # GET /recipients.xml
  def index
    
    if (params[:search_term] || params[:city_section])
      @the_things = the_model_name.constantize.name_like(params[:search_term]) if params[:search_term]
      # search by city_section if that param is passed in (convert city_section string name to key for db lookup first)
      @the_things = the_model_name.constantize.city_section_is(ApplicationHelper::CITY_SECTIONS[params[:city_section]]) if params[:city_section]
    else
      @the_things = the_model_name.constantize.all
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
  
end
