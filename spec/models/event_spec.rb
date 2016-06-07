require 'rails_helper'


RSpec.describe Event, type: :model do
  before(:each) do
    Event.delete_all
  end

  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) {{title: "Festa na casa de Ítalo", description: "testando", category_id: category.id, user_id: user.id}}
  let(:attributes_without_title) {{description: "testando", category_id: category.id, user_id: user.id}}
  let(:attributes_without_category) {{title: "Teste", description: "testando", user_id: user.id}}
  let(:attributes_without_user) {{title: "Teste", description: "testando", category_id: category.id}}

  it "needs category" do
  	expect{ Event.create! attributes_without_category }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Category não pode ficar em branco')
  end

  it "needs title" do
    expect{ Event.create! attributes_without_title }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Title não pode ficar em branco')
  end

  it "needs user" do
    expect{ Event.create! attributes_without_user }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: User não pode ficar em branco')
  end

  it "searches" do
    event = Event.create! valid_attributes
    expect(Event.search('casa').first).to eq(event)
  end
end









