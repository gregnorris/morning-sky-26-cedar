class ItemsController < ApplicationController
  
  def the_model_name;   'Item'; end
  def the_model_symbol; :item;  end
  
  # we want successful create and update actions to redirect back to the index
  def the_update_redirect; 'index'; end
  
  

#  def set_thing_by_id
#    @item = Item.find(params[:id])
#    @the_thing = @item
#  end

#  # GET /items
#  def index
#    @items = Item.all
#    @the_things = @items
#    super
#  end

#  # GET /items/1
#  def show
#    set_thing_by_id
#    super
#  end

#  # GET /items/new
#  def new
#    @item = Item.new
#    @the_thing = @item
#    super
#  end

#  # GET /items/1/edit
#  def edit
#    # need to set the variable for the view
#    set_thing_by_id
#  end

#  # POST /items
#  def create
#    @item = Item.new(params[:item])
#    @the_thing = @item
#    super
#  end

#  # PUT /items/1
#  def update
#    set_thing_by_id
#    super
#  end

#  # DELETE /items/1
#  def destroy
#    set_thing_by_id
#    super
#  end
end
