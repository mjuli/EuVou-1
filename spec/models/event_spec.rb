require 'rails_helper'


RSpec.describe Event, type: :model do

  let(:category) { FactoryGirl.create(:category) }
  let(:attributes_without_title) {{description: "testando", date: Time.new(2016, 7, 6), category_id: category.id}}
  let(:attributes_without_category) {{title: "Teste", description: "testando", date: Time.new(2016, 7, 6)}}


  it "needs category" do
  	expect{ Event.create! attributes_without_category }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Category não pode ficar em branco')
  end

  it "needs title" do
    expect{ Event.create! attributes_without_title }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Title não pode ficar em branco')
  end

end
