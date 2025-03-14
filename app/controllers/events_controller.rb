class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @events = Event.includes(:organization).order(start_time: :asc)
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
    @organizations = current_user.organizations
    
    if @organizations.empty?
      redirect_to new_organization_path, 
                  alert: "You need to create an organization before posting events."
    end
  end
  
  def create
    @event = Event.new(event_params)
    
    # Verify user owns the organization
    unless current_user.organizations.include?(@event.organization)
      return redirect_to events_path, alert: "You can only create events for your organizations"
    end
    
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      @organizations = current_user.organizations
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, 
                                 :location, :image, :organization_id)
  end
end
