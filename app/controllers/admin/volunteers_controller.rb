class Admin::VolunteersController < AdminController
  before_action :find_event
  before_action :find_volunteer_role

  def index
    @leads = @volunteer_role.leads
  end

  def create
    if (@lead = @volunteer_role.volunteers.find_by(user_id: params[:volunteer][:user_id]))
      @lead.update(lead: true)
    else
      @lead = @volunteer_role.volunteers.create!(
        user_id: params[:volunteer][:user_id],
        lead: true
      )
    end
    flash[:notice] = "#{@lead.user.name} added as a lead to #{@lead.volunteer_role.name}"
    LeadsMailer.new_lead(@lead).deliver_now
    redirect_to admin_event_volunteer_role_volunteers_path(@event)
  end

  def destroy
    @lead = @volunteer_role.leads.find(params[:id])
    @lead.update(lead: false)
    flash[:notice] = "#{@lead.user.name} has been removed as a lead to #{@lead.volunteer_role.name}"
    redirect_to admin_event_volunteer_role_volunteers_path(@event)
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_volunteer_role
    @volunteer_role = @event.volunteer_roles.find(params[:volunteer_role_id])
  end
end
