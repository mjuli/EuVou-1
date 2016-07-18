class EventController < ApplicationController
  before_action :set_event, only: [:show, :edit, :destroy]

  def index
  	#events = RestClient.get 'http://jsonplaceholder.typicode.com/posts'
  	#@events = JSON.parse(response).symbolize_keys
  end

  def show
  	event = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
    @evento = JSON.parse(event).symbolize_keys
    #@comentarios =
  end

  def new
  end

  def edit
    event = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Generates coordinates based on
  
    def set_event
      @id = params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      # params.require(:event).permit(:title, :category_id, :description, :date, :images, :user_id, :local, address_attributes: [:id, :location, :lat, :lon])
    end
end
