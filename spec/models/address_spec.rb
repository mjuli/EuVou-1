require 'rails_helper'

RSpec.describe Address, type: :model do
  
  let(:attributes_without_event) {}

  xit "needs attributes" do
  	expect{ Address.create! attributes_without_event }
  	.to raise_error(ActiveRecord::RecordInvalid,'A validação falhou: Event não pode ficar em branco')
  end
end
