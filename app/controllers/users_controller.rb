class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    # @student = ...
    if @user.save
      # Handle a successful save.
      log_in @user
      redirect_to :controller => 'students', :action => 'create'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
