require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm 
    sign_in user
  end
  
  let(:address) { FactoryGirl.create(:address)}
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) {{title: 'event_title', category_id: category.id, user_id: user.id, date: Time.new(2016, 7, 7)}} 
  let(:new_valid_attributes) {{title: 'event_title2', category_id: category.id, user_id: user.id, date: Time.new(2016, 7, 7)}}
  let(:invalid_attributes) {{description: 'event_title'}}
  
  describe "GET #index" do
    it "assigns all events as @events" do
      event1, event2 = FactoryGirl.create(:event, valid_attributes), FactoryGirl.create(:event, valid_attributes)
      address1, address2 = FactoryGirl.create(:address, event_id: event1.id), FactoryGirl.create(:address, event_id: event2.id)
      get :index
      expect(assigns(:events)).to match_array([event1, event2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested event as @event" do
      event = FactoryGirl.create(:event, valid_attributes)
      address = FactoryGirl.create(:address, event_id: event.id)
      get :show, {:id => event.to_param}
      expect(assigns(:event)).to eq(event)
    end

    context "comments #show" do
      it "assigns the requested comment as @comment" do
        event = FactoryGirl.create(:event, valid_attributes)
        address = FactoryGirl.create(:address, event_id: event.id)
        comment = FactoryGirl.create(:comment, user_id: user.id, event_id: event.id)
        get :show, {:id => event.to_param}
        expect(assigns(:comments)).to eq([comment])
      end
    end

    context "comments #new" do
      it "assigns a new comment as @comment" do
        event = FactoryGirl.create(:event, valid_attributes)
        address = FactoryGirl.create(:address, event_id: event.id)
        get :show, {:id => event.to_param}
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end

    context "comments #show" do
      it "assigns the requested comment as @comment" do
        event = Event.create! valid_attributes
        address = FactoryGirl.create(:address, event_id: event.id)
        comment = FactoryGirl.create(:comment, user_id: user.id, event_id: event.id)
        get :show, {:id => event.to_param}
        expect(assigns(:comments)).to eq([comment])
      end
    end

    context "comments #new" do
      it "assigns a new comment as @comment" do
        event = Event.create! valid_attributes
        address = FactoryGirl.create(:address, event_id: event.id)
        get :show, {:id => event.to_param}
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested event as @event" do
      event = Event.create!(valid_attributes)
      address = FactoryGirl.create(:address, event_id: event.id)
      get :edit, {:id => event.to_param}
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST #create" do
    context "with valid params" do

      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it "redirects to the created event" do
        post :create, {:event => valid_attributes}
        expect(response).to redirect_to(Event.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, {:event => invalid_attributes}
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, {:event => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do

      it "updates the requested event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => new_valid_attributes}
        event.reload
        expect(event.title).to eq('event_title2')
      end

      it "redirects to the event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => valid_attributes}
        expect(response).to redirect_to(event)
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        event = Event.create! valid_attributes
        put :update, {:id => event.to_param, :event => invalid_attributes}
        expect(assigns(:event)).to eq(event)
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect {
        delete :destroy, {:id => event.to_param}
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete :destroy, {:id => event.to_param}
      expect(response).to redirect_to(events_url)
    end
  end

end
