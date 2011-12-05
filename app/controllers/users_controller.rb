class UsersController < ApplicationController
  def new
    @user = User.new(:zenpoints => 0)
  end
 
  def show
    @user = User.find(params[:id])
	@title = [@user.firstname,@user.lastname].join(' ').squeeze(' ')
	@email = @user.email
  end

  def create
    @user = User.new(params[:user])	
	@user.set_zenpoints(0)
    if @user.save
	  flash[:success] = "Welcome to CollegeZen!"
      redirect_to root_path
    else
      @title = "Sign up"
      render 'new'
    end
  end
end
