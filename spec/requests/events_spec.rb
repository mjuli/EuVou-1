require 'rails_helper'

RSpec.describe "Events", type: :request do

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

	    expect(page).to have_content("Evento foi criado com sucesso!")
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
      fill_in "Local", with: "Av. Roberto Freire, Natal - RN"
      click_button "Confirmar"

      #screenshot_and_save_page 
      
      within 'h3' do
        expect(page).to have_content("Festa dos Solteiros")
      end
    end
  end

  describe "DELETE /events" do
    it "remove an event", js: true do
      logar
      
      criar_evento

      visit "/events"

      click_link 'Casa de praia'

      within 'h3' do
        expect(page).to have_content("Casa de praia")
      end 
      
      expect{
        click_link 'Remover'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content("Casa de praia")
      }.to change(Event, :count).by(-1)  

      expect(page).to have_content("Evento foi removido com sucesso!")
    end
  end
end
