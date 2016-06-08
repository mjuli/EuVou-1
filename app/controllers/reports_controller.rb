class ReportsController < ApplicationController

  def create
    @event = Event.find(params[:id])
    current_user.report!(@event)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:id])
    current_user.cancel_report!(@event)
    respond_to do |format|
      format.js
    end
  end

end
