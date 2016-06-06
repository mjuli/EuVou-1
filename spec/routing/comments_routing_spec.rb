require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/events/1/comments").to route_to("comments#create", :event_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "events/1/comments/1").to route_to("comments#destroy", :event_id => "1", :id => "1")
    end

  end
end
