require 'rails_helper'

RSpec.describe EuVousController, type: :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm 
    sign_in user
  end
  
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, category_id: category.id, user_id: user.id ) }
  let(:valid_attributes) {{event_id: event.id, user_id: user.id}} 
  let(:invalid_attributes) {}

  describe "POST #create" do

    context "with valid params" do
      xit "creates a new EuVou" do
        expect {
          post :create, {:eu_vou => valid_attributes}
        }.to change(EuVou, :count).by(1)
      end

      xit "assigns a newly created eu_vou as @eu_vou" do
        post :create, {:eu_vou => valid_attributes}
        expect(assigns(:eu_vou)).to be_a(EuVou)
        expect(assigns(:eu_vou)).to be_persisted
      end

      xit "redirects to the created eu_vou" do
        post :create, {:eu_vou => valid_attributes}
        expect(response).to redirect_to(EuVou.last)
      end
    end

    context "with invalid params" do
      xit "assigns a newly created but unsaved eu_vou as @eu_vou" do
        post :create, {:eu_vou => invalid_attributes}
        expect(assigns(:eu_vou)).to be_a_new(EuVou)
      end

      xit "re-renders the 'new' template" do
        post :create, {:eu_vou => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested eu_vou" do
      eu_vou = EuVou.create! valid_attributes
      expect {
        delete :destroy, {:id => eu_vou.to_param}
      }.to change(EuVou, :count).by(-1)
    end

    xit "redirects to the eu_vous list" do
      eu_vou = EuVou.create! valid_attributes
      delete :destroy, {:id => eu_vou.to_param}
      expect(response).to redirect_to(eu_vous_url)
    end
  end

end
