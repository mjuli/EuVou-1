require 'rails_helper'

RSpec.describe "Events", type: :request do

	before(:each) do
		Event.delete_all
		Category.delete_all
	end

	def logar
		@user = FactoryGirl.create(:user)
  	@user.confirm 

  	visit "/users/sign_in"

    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
		
		click_button "Entrar"
	end

  describe "GET /events" do
    xit "creates an event" do
    	category = FactoryGirl.create(:category)
    	
    	logar

    	visit root_path

    	click_link('Novo evento', match: :first)
    	
    	screenshot_and_save_page	
    	
    	expect{
	      fill_in "Título", with: "Festa dos Solteiros"
	      select category.id, :from => "Categoria" 
	      fill_in "Descrição", with: "Casado também pode"
	      fill_in "Local", with: "Av. Roberto Freire, Natal - RN"
	      click_button "Confirmar"
	    }.to change(Event,:count).by(1)

	    expect(page).to have_content("Event was successfully created.")
	    expect(page).to have_content("Festa dos Solteiros")
    end
  end
  
  describe "PUT /events" do
    xit "updates an event" do
    end
  end

  describe "DELETE /events" do
    xit "remove an event" do
    end
  end
end
