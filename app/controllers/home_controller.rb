class HomeController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      head :no_content
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.fetch(:event, {}).permit(
      :title, :start, :end, :allday
    )
  end
  
end
