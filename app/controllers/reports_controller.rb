class ReportsController < ApplicationController

  def create
    @event = Event.find(params[:report][:reported_event_id])
    current_user.report!(@event)
    redirect_to @event
  end

  def destroy
    @event = EuVou.find(params[:id]).reported_event
    current_user.cancel_report!(@event)
    redirect_to @event
  end

end
