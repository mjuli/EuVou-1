class EventsController < ApplicationController
  require 'net/http'
	before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :json
  # GET /events
  # GET /events.json
  def index
		@events = Event.search(params[:search]).order(date: :asc).where('date >= ?', Date.today)
    @address = Address.all
    
    if(params[:category_id])
      @events = @events.where('category_id = ?', params[:category_id])
    end
    
    @categories = Category.order(name: :asc)
  	@events_upcoming = Event.upcoming
    @events_past = Event.past
    respond_to do |format|
      format.html # user_show.html.erb
      format.json {render json: @events.as_json}
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comments = @event.comments
    @comment = Comment.new
    @address = @event.address
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.build_address
  end

  # GET /events/1/edit
  def edit
		authorize_action_for @event
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
		@event.user = current_user
		
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Evento foi criado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
		authorize_action_for @event
    
    respond_to do |format|
      if @event.update(event_params)  
        format.html { redirect_to @event, notice: 'Evento atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
		authorize_action_for @event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Evento foi removido com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Generates coordinates based on
  
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
			params.require(:event).permit(:title, :category_id, :description, :date, :image, :image_cache, :user_id, :local,  :location, address_attributes: [:id, :place, :location, :lat, :lon])
    end
    
end
