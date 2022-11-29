class UsersController < ApplicationController
  def new
  end

  def destroy
    @user.destroy
    redirect_to _path, status: :see_other
  end
end
