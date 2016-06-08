require 'rails_helper'

RSpec.describe Address, type: :model do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:event) {FactoryGirl.create(:event, category_id: category.id, user_id: user.id)}
  let(:attributes_without_event) {{location: 'Rua dos Bobos'}}
  let(:attributes_without_location) {{event_id: event.id}}

  it "needs location" do
  	expect{ Address.create! attributes_without_location }
  	.to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Location não pode ficar em branco')
  end
end
