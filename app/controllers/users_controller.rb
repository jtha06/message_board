class UsersController < ApplicationController
  def new
    @user = User.new
  end
 
  def show
    @user = User.find(params[:id])
	@title = [@user.firstname,@user.lastname].join(' ').squeeze(' ')
	@email = @user.email
  end

  def create
    @user = User.new(params[:user])
    if @user.save
	  flash[:success] = "Welcome to CollegeZen!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

end
