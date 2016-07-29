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
    evento = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id
    @evento = JSON.parse(evento).symbolize_keys[:data].symbolize_keys
    puts @evento
    @user = JSON.parse(RestClient.get 'http://euvouapi.herokuapp.com/users/' + @evento[:relationships]["user"]["data"]["id"])
  end

  def create
    time = params[:time]["(4i)"] + ":" + params[:time]["(5i)"] + ":00"
    
    if session[:current_user] == nil
      
      respond_to do |format|
        format.html { redirect_to "/login", notice: 'Usuário deve estar logado!' }
      end
    
    else
    
      response = RestClient.get 'http://euvouapi.herokuapp.com/oauth/token/info', {:Authorization => 'Bearer ' + session[:current_user]["access_token"]}
      user_info = JSON.parse(response).symbolize_keys
      user_id = user_info[:resource_owner_id]
      
      RestClient.post 'https://euvouapi.herokuapp.com/events', 
      {"event" => {
        "title" => params[:title], 
        "description" => params[:description], 
        "date" => params[:date_field], 
        "time" => time, 
        "user_id" => user_id, 
        "category_id" => params[:category_id].to_i, 
        "address_attributes"  => {
          "lat" => "-5.809956", 
          "lon" => "-35.206202", 
          "location" => "Midway Mall"}
         }
      }, 
      {:Authorization => 'Bearer ' + session[:current_user]["access_token"]}
      
      respond_to do |format|
        format.html { redirect_to "/event", notice: 'Evento Criado com Sucesso!' }
      end
      
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
    def lat_lon(address)
      # Escape any non_ASCII characters and convert the string into a URI object.
      encoded_url = URI.escape(
        'https://maps.googleapis.com/maps/api/geocode/json?address=' + address
      )
      url = URI.parse((encoded_url))

      # Make the request to retrieve the JSON string
      response = open(url).read

      # Convert the JSON string into a Hash object
      result = JSON.parse(response)

      # Extract the latitude and longitude and return them
      lat = result['results'][0]['geometry']['location']['lat']
      lon = result['results'][0]['geometry']['location']['lng']
      return lat, lon
    end
  
    def set_event
      @id = params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :category_id, :description, :date, :time, :image, :user_id, :local, address_attributes: [:id, :location, :lat, :lon])
    end

end
