class Admin::VolunteerRolesController < AdminController
  before_action :find_event

  def index
    @volunteer_roles = @event.volunteer_roles.all
  end

  def new
    @volunteer_role = @event.volunteer_roles.new
  end

  def create
    @volunteer_role = @event.volunteer_roles.new(volunteer_role_params)
    if @volunteer_role.save
      redirect_to admin_event_volunteer_roles_path(@event)
    else
      render action: :new
    end
  end

  def edit
    @volunteer_role = @event.volunteer_roles.find(params[:id])
  end

  def update
    @volunteer_role = @event.volunteer_roles.find(params[:id])
    if @volunteer_role.update(volunteer_role_params)
      redirect_to admin_event_volunteer_roles_path(@event)
    else
      render action: :edit
    end
  end

  def destroy
    @volunteer_role = @event.volunteer_roles.find(params[:id])
    @volunteer_role.destroy!
    redirect_to admin_event_volunteer_roles_path(@event)
  end

  private

  def volunteer_role_params
    params.require(:volunteer_role).permit(:name, :description)
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
