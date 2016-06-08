require 'rails_helper'

RSpec.describe "reports/new", type: :view do
  before(:each) do
    assign(:report, Report.new(
      :reportee => nil,
      :reported_event => nil
    ))
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do

      assert_select "input#report_reportee_id[name=?]", "report[reportee_id]"

      assert_select "input#report_reported_event_id[name=?]", "report[reported_event_id]"
    end
  end
end
