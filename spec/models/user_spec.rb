require 'rails_helper'

RSpec.describe User, type: :model do
  User.delete_all

  let(:valid_attributes) {{name: "Eu Vou"}}
  let(:attributes_without_name) {{email: Faker::Internet.email, password: "password"}}
  let(:attributes_without_email) {{name: "Eu Vou", password: "password"}}
  let(:invalid_email) {{name: "Eu Vou", email: 'erro', password: "password"}}
  
  it "needs name" do
  	expect{ User.create! attributes_without_name }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Name não pode ficar em branco')
  end

  it "needs email" do
  	expect{ User.create! attributes_without_email }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Email não pode ficar em branco')
  end

  it "needs valid email" do
    expect{ User.create! invalid_email }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Email não é válido')
  end
end
