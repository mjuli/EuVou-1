require 'rails_helper'

RSpec.describe "reports/edit", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      :reportee => nil,
      :reported_event => nil
    ))
  end

  it "renders the edit report form" do
    render

    assert_select "form[action=?][method=?]", report_path(@report), "post" do

      assert_select "input#report_reportee_id[name=?]", "report[reportee_id]"

      assert_select "input#report_reported_event_id[name=?]", "report[reported_event_id]"
    end
  end
end
