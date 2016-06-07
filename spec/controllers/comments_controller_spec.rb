require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  #usuario precisa estar logado
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm 
    sign_in user
  end

  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, category_id: category.id, user_id: user.id ) }
  let(:valid_attributes) {{body: 'Esse evento promete!'}} 
  let(:invalid_attributes) {}

  #Estão no events_controller_spec.rb:
  # describe "GET #show" do 
  # describe "GET #new" do 

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:event_id => event.id, :comment => valid_attributes}
        }.to change(event.comments, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:event_id => event.id, :comment => valid_attributes}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "redirects to the event with the comment" do
        post :create, {:event_id => event.id, :comment => valid_attributes}
        expect(response).to redirect_to(event)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = FactoryGirl.create(:comment, user_id: user.id, event_id: event.id) 
      expect {
        delete :destroy, {:event_id => event.id, :id => comment.to_param}
      }.to change(event.comments, :count).by(-1)
    end

    it "redirects to the event page" do
      comment = FactoryGirl.create(:comment, user_id: user.id, event_id: event.id) 
      delete :destroy, {:event_id => event.id, :id => comment.to_param}
      expect(response).to redirect_to(event)
    end
  end

end
