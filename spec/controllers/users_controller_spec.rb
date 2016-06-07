require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm 
    sign_in user
  end
  
  let(:user) { FactoryGirl.create(:user)}
  let(:user2) { FactoryGirl.create(:user)}
  let(:valid_attributes) {{title: 'event_title', category_id: category.id, date: Time.new(2016, 7, 7), user_id: user.id}}
  let(:new_valid_attributes) {{title: 'event_title2', category_id: category.id, date: Time.new(2016, 8, 8), user_id: user.id}}
  let(:invalid_attributes) {{description: 'event_title'}}
  
  skip("o q finish_signup faz?")
  #describe "GET #finish_signup" do

  describe "GET #user_show" do
    it "renders the show template" do
       get :user_show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

end