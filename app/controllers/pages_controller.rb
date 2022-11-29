class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end


  def user_dash
  end

  def about_us
  end

end
