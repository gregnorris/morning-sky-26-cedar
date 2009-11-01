class DonorsController < ApplicationController

  def set_thing_by_id
    @donor = Donor.find(params[:id])
    @the_thing = @donor
  end

  # GET /donors
  def index
    @donors = Donor.all
    @the_things = @donors
    super
  end

  # GET /donors/1
  def show
    set_thing_by_id
    super
  end

  # GET /donors/new
  def new
    @donor = Donor.new
    @the_thing = @donor
    super
  end

  # GET /donors/1/edit
  def edit
    # need to set the variable for the view
    set_thing_by_id
  end

  # POST /donors
  def create
    @donor = Donor.new(params[:donor])
    @the_thing = @donor
    super
  end

  # PUT /donors/1
  def update
    set_thing_by_id
    super
  end

  # DELETE /donors/1
  def destroy
    set_thing_by_id
    super
  end

end
