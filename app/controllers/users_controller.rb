class UsersController < ApplicationController
  def new
  end
 
  def show
    @user = User.find(params[:id])
	@title = [@user.firstname,@user.lastname].join(' ').squeeze(' ')
	@email = @user.email
  end

end
