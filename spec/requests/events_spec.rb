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
  
  def criar_evento
    category = FactoryGirl.create(:category)
    @event = FactoryGirl.create(:event, title: "Casa de praia", user_id: @user.id, category_id: category.id)
    address = FactoryGirl.create(:address, event_id: @event.id)
  end

  describe "GET /events" do
    it "creates an event" do
    	category = FactoryGirl.create(:category)
    	
    	logar

    	visit root_path

    	click_link('Novo evento', match: :first)
    	
    	expect{
	      fill_in "Título", with: "Festa dos Solteiros"
	      select "Musica", from: "event[category_id]"
	      fill_in "Descrição", with: "Casado também pode"
	      fill_in "Local", with: "Av. Roberto Freire, Natal - RN"
	      click_button "Confirmar"
	    }.to change(Event,:count).by(1)

	    expect(page).to have_content("Event was successfully created.")
	    expect(page).to have_content("Festa dos Solteiros")
    end
  end
  
  describe "PUT /events" do
    it "updates an event" do
      logar
      criar_evento

      visit root_path

      click_link 'Casa de praia'

      within 'h3' do
        expect(page).to have_content("Casa de praia")
      end
      
      click_link 'Editar'
      
      fill_in "Título", with: "Festa dos Solteiros"
      click_button "Confirmar"
      
      within 'h3' do
        expect(page).to have_content("Festa dos Solteiros")
      end
    end
  end

  describe "DELETE /events" do
    it "remove an event", js: true do
      logar
      criar_evento

      visit root_path

      click_link 'Casa de praia'

      within 'h3' do
        expect(page).to have_content("Casa de praia")
      end

      #screenshot_and_save_page  
      
      expect{
        click_link 'Remover'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content("Casa de praia")
      }.to change(Event,:count).by(-1)  

      expect(page).to have_content("Event was successfully destroyed.")
    end
  end
end
