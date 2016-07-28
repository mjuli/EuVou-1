class EventController < ApplicationController
  before_action :set_event, only: [:show, :edit, :destroy]
  # before_action :fake_event, only: [:show, :index]

  def index
    events = RestClient.get 'http://euvouapi.herokuapp.com/events/'
    @events = JSON.parse(events).symbolize_keys[:data]
    # puts ">>>>Debug do evento id<<<<"
    # puts @events[1]["id"]
  end

  def show
    evento = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
    @evento = JSON.parse(evento).symbolize_keys[:data].symbolize_keys
    #@user = RestClient.get 'http://euvouapi.herokuapp.com/users/' + @evento[:relationships]["user"]["id"]
    
  end

  def create
    if session[:current_user] == nil
      respond_to do |format|
        format.html { redirect_to "/login", notice: 'Usuário deve estar logado!' }
      end
      
    else
      #user_id = session[:current_user][id"]
      #RestClient.post ("https://euvouapi.herokuapp.com/events", {:event => params}.json)
    end
  end


  def edit
    @event = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    # authorize_action_for @event
    
    # respond_to do |format|
    #   if @event.update(event_params)  
    #     @event.lat, @event.lon = lat_lon(@event.address)
    #     format.html { redirect_to @event, notice: 'Event was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @event }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    # authorize_action_for @event
    # @event.destroy
    # respond_to do |format|
    #   format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
  
    def set_event
      @id = params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :category_id, :description, :date, :time, :image, :user_id, :local, address_attributes: [:id, :location, :lat, :lon])
    end

end
