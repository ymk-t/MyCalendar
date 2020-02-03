class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
