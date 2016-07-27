class EventController < ApplicationController
  before_action :set_event, only: [:show, :edit, :destroy]
  before_action :fake_event, only: [:show, :index]

  def index
    events = RestClient.get 'http://jsonplaceholder.typicode.com/posts'
  	@events = JSON.parse(events)
  end

  def show
  	#@evento = @events[@id.to_i]
    evento = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
    data = JSON.parse(evento).symbolize_keys[:data]["attributes"]
    @evento = data.symbolize_keys

    #@evento = format(evento)
    
    #@evento = JSON.parse(evento).symbolize_keys
    #@comentarios =
  end

  def new
    if session[:current_user] == nil
      respond_to do |format|
        format.html { redirect_to "/login", notice: 'Usuário deve estar logado!' }
      end
    else
      #RestClient.post ("https://euvouapi.herokuapp.com/events", {:event => params}.json)
    end
  end


  def edit
    event = RestClient.get 'http://euvouapi.herokuapp.com/events/' + @id.to_s
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
    # Use callbacks to share common setup or constraints between actions.
    # Generates coordinates based on
  
    def set_event
      @id = params[:id]
    end

    def format(hash)
      output = Hash.new
      hash.each do |key, value|
        output[key] = cleanup(value)
      end
      return output
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      # params.require(:event).permit(:title, :category_id, :description, :date, :images, :user_id, :local, address_attributes: [:id, :location, :lat, :lon])
    end

    def fake_event
      @eventos = [{ "id": 1,
                "title": "Evento_01", 
                "description": "Mussum Ipsum, cacilds vidis litro abertis. Interagi no mé, cursus quis, vehicula ac nisi. Quem num gosta di mé, boa gente num é. Suco de cevadiss deixa as pessoas mais interessantiss.",
                "image": "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg",
                "date": "10/10/2016",
                "time": "22:00",
                "user_id": 1,
                "category_id": 1,
                "location": "Rua das Flores, 123"},
                { "id": 2,
                "title": "Evento_02", 
                "description": "Mussum Ipsum, cacilds vidis litro abertis. Interagi no mé, cursus quis, vehicula ac nisi. Quem num gosta di mé, boa gente num é. Suco de cevadiss deixa as pessoas mais interessantiss.",
                "image": "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg",
                "date": "01/10/2016",
                "time": "22:00",
                "user_id": 1,
                "category_id": 1,
                "location": "Rua das Flores, 123"},
                { "id": 3,
                "title": "Evento_03", 
                "description": "Mussum Ipsum, cacilds vidis litro abertis. Interagi no mé, cursus quis, vehicula ac nisi. Quem num gosta di mé, boa gente num é. Suco de cevadiss deixa as pessoas mais interessantiss.",
                "image": "http://larissacrivellarieventos.com/layout/uploads/images/musica.jpg",
                "date": "11/10/2016",
                "time": "22:00",
                "user_id": 1,
                "category_id": 1,
                "location": "Rua das Flores, 123"},
                {"id": 4,
                "title": "Evento_04", 
                "description": "Mussum Ipsum, cacilds vidis litro abertis. Interagi no mé, cursus quis, vehicula ac nisi. Quem num gosta di mé, boa gente num é. Suco de cevadiss deixa as pessoas mais interessantiss.",
                "image": "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg",
                "date": "09/10/2016",
                "time": "22:00",
                "user_id": 1,
                "category_id": 1,
                "location": "Rua das Flores, 123"}]
      @users = [{"name": "Luan1", "email": "luan1.goncbs@gmail.com", "password": "password1"}, 
                {"name": "Luan2", "email": "luan1.goncbs@gmail.com", "password": "password1"}, 
                {"name": "Luan3", "email": "luan1.goncbs@gmail.com", "password": "password1"}]
      #@user = users[params[:id].to_i-1]
    end
end
