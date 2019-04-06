class Admin::VolunteersController < AdminController
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
    redirect_to admin_volunteer_role_volunteers_path
  end

  private

  def find_volunteer_role
    @volunteer_role = VolunteerRole.find(params[:volunteer_role_id])
  end
end
