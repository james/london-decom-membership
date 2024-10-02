class Admin::EventsController < AdminController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to admin_events_path(@event)
    else
      render action: :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to admin_event_path(@event)
    else
      render action: :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :active,
      :ticket_sale_start_date, :theme, :theme_details, :theme_image_url,
      :location, :maps_location_url, :event_timings, :further_information,
      :ticket_price_info, :ticket_information, :event_date, :event_mode,
      :low_income_requests_start, :low_income_requests_end
    )
  end
end
