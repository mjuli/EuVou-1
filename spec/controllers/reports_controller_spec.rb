require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) {FactoryGirl.create(:event, category_id: category.id, user_id: user.id)}
  let(:address) { FactoryGirl.create(:address, event_id: event.id)}
  let(:valid_attributes) {{reportee_id: user.id, reported_event_id: event.id}} 
  let(:invalid_attributes) {}


  describe "POST #create" do
    context "with valid params" do
      xit "creates a new Report" do
        expect {
          post :create, {:report => valid_attributes}
        }.to change(Report, :count).by(1)
      end

      it "assigns a newly created report as @report" do
        post :create, {:report => valid_attributes}
        expect(assigns(:report)).to be_a(Report)
        expect(assigns(:report)).to be_persisted
      end

      it "redirects to the created report" do
        post :create, {:report => valid_attributes}
        expect(response).to redirect_to(Report.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved report as @report" do
        post :create, {:report => invalid_attributes}
        expect(assigns(:report)).to be_a_new(Report)
      end

      it "re-renders the 'new' template" do
        post :create, {:report => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested report" do
      report = Report.create! valid_attributes
      expect {
        delete :destroy, {:id => report.to_param}
      }.to change(Report, :count).by(-1)
    end

    xit "redirects to the reports list" do
      report = Report.create! valid_attributes
      delete :destroy, {:id => report.to_param}
      expect(response).to redirect_to(reports_url)
    end
  end

end
