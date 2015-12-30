class VisitorsController < ApplicationController
  before_action :check_login

  private
  def check_login
    if user_signed_in?
      redirect_to users_profile_path
    end
  end
end
