class EuVousController < ApplicationController

	def create
		@event = Event.find(params[:eu_vou][:attended_event_id])
    current_user.attend!(@event)
    redirect_to @event
  end

  def destroy
    @event = EuVou.find(params[:id]).attended_event
    current_user.cancel_attend!(@event)
    redirect_to @event
  end

end
