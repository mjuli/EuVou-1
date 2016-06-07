require 'rails_helper'

RSpec.describe Category, type: :model do

  it "needs name" do
    expect{ Category.create! }
    .to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Name não pode ficar em branco')
  end
end
