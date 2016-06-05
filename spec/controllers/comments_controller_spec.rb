require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  Comment.delete_all

  let(:valid_attributes) {{body: 'Esse evento promete!'}} 
  let(:invalid_attributes) {}

  #Estão no events_controller_spec.rb:
  # describe "GET #show" do 
  # describe "GET #new" do 

  skip("CREATE and DESTROY => Perguntar para Rebeca")
  #ATENÇÃO 
  # describe "POST #create" do
  # describe "DELETE #destroy" do  
  

end
