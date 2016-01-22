# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def edit
    profile = current_user.profile
    #byebug
    current_user.profile = Profile.new unless profile
  end

  def update
    super
  end

  protected

    def after_update_path_for(resource)
      profile_path
    end
end 