require 'rails_helper'

RSpec.describe "Comments", type: :request do

  describe "CREATE /comments" do
    xit "creates a comment and redirects to the event's page" do

	    get "/events/:id"
	    expect(response).to render_template("/event/:id")

	    post "/event/:id/comments", :comment => {:body => "Testando"}

	    expect(response).to redirect_to(event)
	    follow_redirect!

	    expect(response).to render_template("/event/:id")
	  end
  end

  describe "DESTROY /comments" do
    xit "creates a Widget and redirects to the Widget's page" do
	    get "/widgets/new"
	    expect(response).to render_template(:new)

	    post "/widgets", :widget => {:name => "My Widget"}

	    expect(response).to redirect_to(assigns(:widget))
	    follow_redirect!

	    expect(response).to render_template(:show)
	    expect(response.body).to include("Widget was successfully created.")
	  end
  end
end
