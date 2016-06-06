require 'rails_helper'

RSpec.describe "Comments", type: :request do
	before(:each) do
		Event.delete_all
		category = FactoryGirl.create(:category)
		user = FactoryGirl.create(:user)
  	@event = FactoryGirl.create(:event, title: "Festa na Praia", category_id: category.id, user_id: user.id)
  	address = FactoryGirl.create(:address, event_id: @event.id)
	end

	def logar
		@user2 = FactoryGirl.create(:user)
  	@user2.confirm 

  	visit "/users/sign_in"

    fill_in "Email",    :with => @user2.email
    fill_in "Password", :with => @user2.password
		
		click_button "Entrar"
	end

	def comentar
		visit event_path(@event.id)

		expect(page).to have_content("Festa na Praia")

  	fill_in "Novo comentário", with: "Festa legal"
		click_button "Salvar"
	end

  describe "CREATE /comments" do
    it "creates a comment and redirects to the event's page" do
    	logar
    	comentar

			#screenshot_and_save_page	
 			expect(page).to have_content("Festa legal")
	  end
  end

  describe "DESTROY /comments" do
    it "delete a comment" do
	    logar
    	comentar
	 			
 			expect(page).to have_content("Festa legal")

 			click_link "×"

			expect(page).to_not have_content("Festa legal") 			

	  end
  end
end
