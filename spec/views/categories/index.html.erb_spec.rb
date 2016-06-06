require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(:name => "arte")
    ])
  end

  it "renders a list of categories" do
    render :partial => "categories/index.html.erb"
    expect(rendered).to match /arte/
  end
end
