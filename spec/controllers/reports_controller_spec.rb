require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm 
    sign_in user
  end

  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) {FactoryGirl.create(:event, category_id: category.id, user_id: user.id)}
  let(:address) { FactoryGirl.create(:address, event_id: event.id)}
  let(:valid_attributes) {{reportee_id: user.id, reported_event_id: event.id}} 


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Report" do
        expect {
          post :create, { :id => event.id, :report => valid_attributes, :format => :js}
        }.to change(Report, :count).by(1)
      end

      it "re-render the 'create' template" do
        post :create, { :id => event.id, :report => valid_attributes, :format => :js}
        expect(response).to render_template(:create)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested report" do
      report = Report.create! valid_attributes
      expect {
        delete :destroy, {:id => event.id, :format => :js}
      }.to change(Report, :count).by(-1)
    end

    it "redirects to the reports list" do
      report = Report.create! valid_attributes
      delete :destroy, {:id => event.id, :format => :js}
      expect(response).to render_template(:destroy)
    end
  end

end
