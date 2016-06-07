require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event, user_id: user.id, category_id: category.id)}
  #let(:valid_attributes) {{body: "Festa imperdivel", user_id: user.id, event_id: event.id}}
  let(:attributes_without_body) {{user_id: user.id, event_id: event.id}}
  

  it "needs body" do
  	expect{ Comment.create! attributes_without_body }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Body não pode ficar em branco')
  end

  
end
