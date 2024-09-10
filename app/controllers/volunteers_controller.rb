class VolunteersController < ApplicationController
  before_action :find_event
  before_action :find_volunteer_role
  before_action :authenticate_lead, except: %i[new create destroy]

  def index
    @volunteers = @volunteer_role.volunteers.order(:created_at)
    respond_to do |format|
      format.html
      format.csv { send_data @volunteers.to_csv, filename: "volunteers-#{@volunteer_role.name}-#{Date.today}.csv" }
    end
  end

  def new
    @volunteer = current_user.volunteers.build(volunteer_role: @volunteer_role)
  end

  def create
    @volunteer = current_user.volunteers.build(volunteer_params)
    if @volunteer.save
      LeadsMailer.new_volunteer(@volunteer).deliver_now
      redirect_to event_volunteering_index_path(@event)
    else
      render action: :new
    end
  end

  def destroy
    if current_user.lead_for?(@volunteer_role)
      lead_deleting_volunteer
    else
      volunteer_cancelling
    end
  end

  def update
    @volunteer = @volunteer_role.volunteers.find(params[:id])
    @volunteer.update(state: params[:volunteer][:state])
    redirect_to event_volunteer_role_volunteers_path(@event, @volunteer_role)
  end

  private

  def lead_deleting_volunteer
    @volunteer = @volunteer_role.volunteers.find(params[:id])
    @volunteer.destroy
    flash[:notice] = "#{@volunteer.user.name} has been removed as a volunteer"

    if current_user.lead_for?(@volunteer_role)
      redirect_to event_volunteer_role_volunteers_path(@event, @volunteer_role)
    else
      redirect_to root_path
    end
  end

  def volunteer_cancelling
    @volunteer = current_user.volunteers.find_by(volunteer_role: @volunteer_role)
    @volunteer.destroy
    LeadsMailer.cancelled_volunteer(@volunteer).deliver_now
    flash[:notice] = "You are no longer volunteering for #{@volunteer_role.name}"
    redirect_to event_volunteering_index_path(@event)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_volunteer_role
    @volunteer_role = @event.volunteer_roles.find(params[:volunteer_role_id])
  end

  def volunteer_params
    params.require(:volunteer).permit(
      :accept_code_of_conduct,
      :accept_health_and_safety,
      :additional_comments,
      :phone
    ).merge(volunteer_role: @volunteer_role)
  end

  def authenticate_lead
    return if current_user.admin? || Volunteer.find_by(user: current_user, volunteer_role: @volunteer_role, lead: true)

    flash[:alert] = 'You are not permitted to view that page'
    redirect_to root_path
  end
end
