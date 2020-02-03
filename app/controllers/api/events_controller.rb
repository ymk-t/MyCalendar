class Api::EventsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def index
    @events = Event.all
    render 'index', formats: :json, handlers: 'jbuilder'
  end

  def show
    @event = Event.find(params[:id])
    render 'show', formats: :json, handlers: 'jbuilder'
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end
  
  def event_params
    params.fetch(:event, {}).permit(
      :title, :start, :end, :allday
    )
  end
end
