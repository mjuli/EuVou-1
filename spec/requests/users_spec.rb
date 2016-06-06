require 'rails_helper'

RSpec.describe "Users", type: :request do
	Event.delete_all

  describe "user sign_in" do
	  it "allows users to sign in after they have registered" do
	  	user = FactoryGirl.create(:user)
    	user.confirm 
	    
	    visit "/users/sign_in"

	    fill_in "Email",    :with => user.email
	    fill_in "Password", :with => user.password
			
			click_button "Entrar"

	    expect(page).to have_content("Login efetuado com sucesso!")
	  end
	end

	describe "user sign up" do
  	it "register an user" do
  		user = FactoryGirl.create(:user)

      visit new_user_registration_path
      #visit "/users/sign_up"
      
      fill_in 'Nome', with: user.name
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      fill_in 'Confirmação de senha', with: user.password_confirmation
      
      click_button "Criar conta"
    
      expect(page).to have_content("Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail.")
      
      within 'li' do
        expect(page).to have_content("Últimos eventos")
        expect(page).to have_content("Navegar por categorias")
      end

      expect(user2.confirm).to change(User, :count).by(1)

    end
  end

end
