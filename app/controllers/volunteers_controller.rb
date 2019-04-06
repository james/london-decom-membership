class VolunteersController < ApplicationController
  before_action :find_volunteer_role

  def new
    @volunteer = current_user.volunteers.build(volunteer_role: @volunteer_role)
  end

  def create
    @volunteer = current_user.volunteers.build(volunteer_params)
    if @volunteer.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def find_volunteer_role
    @volunteer_role = VolunteerRole.find(params[:volunteer_role_id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:accept_code_of_conduct, :accept_health_and_safety)
          .merge(volunteer_role: @volunteer_role)
  end
end
