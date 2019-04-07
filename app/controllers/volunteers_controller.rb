class VolunteersController < ApplicationController
  before_action :find_volunteer_role
  before_action :authenticate_lead, except: %i[new create destroy]

  def index
    @volunteers = @volunteer_role.volunteers
  end

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

  def destroy
    @volunteer = current_user.volunteers.find_by(volunteer_role: @volunteer_role)
    @volunteer.destroy
    redirect_to root_path
  end

  def update
    @volunteer = @volunteer_role.volunteers.find(params[:id])
    @volunteer.update(state: params[:volunteer][:state])
    redirect_to volunteer_role_volunteers_path(@volunteer_role)
  end

  private

  def find_volunteer_role
    @volunteer_role = VolunteerRole.find(params[:volunteer_role_id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:accept_code_of_conduct, :accept_health_and_safety)
          .merge(volunteer_role: @volunteer_role)
  end

  def authenticate_lead
    return if current_user.admin? || Volunteer.find_by(user: current_user, volunteer_role: @volunteer_role, lead: true)

    render plain: 'You are not permitted to view this'
  end
end
