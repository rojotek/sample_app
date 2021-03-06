class UsersController < ApplicationController
  before_filter :authenticate, only: [:edit, :update, :index, :destroy] 
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :not_for_signed_in, only: [:new, :create]
  
  def new  
    @user = User.new
    @title = "Sign up"
  end
  
  def index
    @title = "All users"
    @users = User.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success]="Welcome to the Sample App!"
      sign_in(@user)
      redirect_to @user
    else
      @title= "Sign up" 
      @user.password=""
      @user.password_confirmation=""
      render 'new'
    end
  end
  def show
    @user = User.find(params[:id])
    @title = "Details for #{@user.name}"
  end
  def edit
    @title = "Edit user"
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end   
  
  def destroy
    if params[:id]==current_user.id then
      flash[:error] = "Cannot delete yourself."
      redirect_to users_path
    else
      User.find(params[:id]).destroy 
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
  end  
  
  private
    def authenticate
      deny_access unless signed_in? 
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end  
    
    def admin_user 
      redirect_to(root_path) unless current_user.admin?
    end
    
end
