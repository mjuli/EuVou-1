class ReportsController < ApplicationController

  def create
    @event = Event.find(params[:reported_event_id])
    current_user.report!(@event)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:reported_event_id])
    current_user.cancel_report!(@event)
    respond_to do |format|
      format.js
    end
  end

end
