class Admin::VolunteerRolesController < AdminController
  def index
    @volunteer_roles = VolunteerRole.all
  end

  def new
    @volunteer_role = VolunteerRole.new
  end

  def create
    @volunteer_role = VolunteerRole.new(volunteer_role_params)
    if @volunteer_role.save
      redirect_to admin_volunteer_roles_path
    else
      render action: :new
    end
  end

  def edit
    @volunteer_role = VolunteerRole.find(params[:id])
  end

  def update
    @volunteer_role = VolunteerRole.find(params[:id])
    if @volunteer_role.update(volunteer_role_params)
      redirect_to admin_volunteer_roles_path
    else
      render action: :edit
    end
  end

  def destroy
    @volunteer_role = VolunteerRole.find(params[:id])
    @volunteer_role.destroy!
    redirect_to admin_volunteer_roles_path
  end

  private

  def volunteer_role_params
    params.require(:volunteer_role).permit(:name, :description)
  end
end
