class RecipientsController < ApplicationController

  def the_model_name;   'Recipient'; end
  def the_model_symbol; :recipient;  end

#  # GET /recipients
#  # GET /recipients.xml
#  def index
#    @recipients = Recipient.all
#    @the_things = @recipients
#    super

##    respond_to do |format|
##      format.html # index.html.erb
##      format.xml  { render :xml => @recipients }
##    end
#  end

#  # GET /recipients/1
#  # GET /recipients/1.xml
#  def show
#    @recipient = Recipient.find(params[:id])
#    @the_thing = @recipient
#    super

##    respond_to do |format|
##      format.html # show.html.erb
##      format.xml  { render :xml => @recipient }
##    end
#  end

#  # GET /recipients/new
#  # GET /recipients/new.xml
#  def new
#    @recipient = Recipient.new
#    @the_thing = @recipient
#    super

##    respond_to do |format|
##      format.html # new.html.erb
##      format.xml  { render :xml => @recipient }
##    end
#  end

#  # GET /recipients/1/edit
#  def edit
#    @recipient = Recipient.find(params[:id])  # need to set the variable for the view
#  end

#  # POST /recipients
#  # POST /recipients.xml
#  def create
#    @recipient = Recipient.new(params[:recipient])
#    @the_thing = @recipient
#    super

##    respond_to do |format|
##      if @recipient.save
##        flash[:notice] = 'Recipient was successfully created.'
##        format.html { redirect_to(@recipient) }
##        format.xml  { render :xml => @recipient, :status => :created, :location => @recipient }
##      else
##        format.html { render :action => "new" }
##        format.xml  { render :xml => @recipient.errors, :status => :unprocessable_entity }
##      end
##    end
#  end

#  # PUT /recipients/1
#  # PUT /recipients/1.xml
#  def update
#    @recipient = Recipient.find(params[:id])
#    @the_thing = @recipient
#    super

##    respond_to do |format|
##      if @recipient.update_attributes(params[:recipient])
##        flash[:notice] = 'Recipient was successfully updated.'
##        format.html { redirect_to(@recipient) }
##        format.xml  { head :ok }
##      else
##        format.html { render :action => "edit" }
##        format.xml  { render :xml => @recipient.errors, :status => :unprocessable_entity }
##      end
##    end
#  end

#  # DELETE /recipients/1
#  # DELETE /recipients/1.xml
#  def destroy
#    @recipient = Recipient.find(params[:id])
#    @recipient.destroy

#    respond_to do |format|
#      format.html { redirect_to(recipient_url) }
#      format.xml  { head :ok }
#    end
#  end

end
