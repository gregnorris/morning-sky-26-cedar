class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def the_model_name;   'User'; end
  def the_model_symbol; :user;  end
  
  # only the admin (gnorris) can see the users index to create users accounts initially
  def index
    if current_user.andand.login == 'gnorris'
      super
    else
      flash[:notice] = "this action is restricted to the administrator"
      redirect_back_or_default account_url
    end
  end
  
  def destroy
    if current_user.andand.login == 'gnorris'
      super
    else
      flash[:notice] = "this action is restricted to the administrator"
      redirect_back_or_default account_url
    end
  end
  
  # only admin can create new users
  def new
    if current_user.andand.login == 'gnorris'
      @user = User.new
    else
      redirect_to account_url
    end
  end
  
  # new user accounts can only be created by the admin from the users index
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      #redirect_back_or_default account_url
      redirect_to users_path
    else
      flash[:error] = @user.errors
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
