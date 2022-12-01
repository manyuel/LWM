class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def new
    @user = User.new
  end

  def destroy
    @user.destroy
    redirect_to _path, status: :see_other
  end
end
