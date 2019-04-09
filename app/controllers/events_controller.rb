class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @volunteer_roles = @event.volunteer_roles.available_for_user(current_user).all
  end
end
