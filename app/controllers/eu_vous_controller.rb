class EuVousController < ApplicationController

	def create
		@event = Event.find(params[:attended_event_id])
    current_user.attend!(@event)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:attended_event_id])
    current_user.cancel_attend!(@event)
    respond_to do |format|
      format.js
    end
  end

end
