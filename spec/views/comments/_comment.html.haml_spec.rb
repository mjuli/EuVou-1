require 'rails_helper'

RSpec.describe "comments/comment", type: :view do
  
  category = FactoryGirl.create(:category) 
  user = FactoryGirl.create(:user) 
  event = FactoryGirl.create(:event, user_id: user.id, category_id: category.id)
  

  xit "renders a list of comments" do
    comment = FactoryGirl.create(:comment, user_id: user.id, event_id: event.id)
    patch :comment, :comment => comment, :partial => "comments/comment.html.erb"
    
    expect(rendered).to match /Evento legal/
  end
end
