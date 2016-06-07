require 'rails_helper'

RSpec.describe "Users", type: :request do

	def logar
		@user = FactoryGirl.create(:user)
  	@user.confirm 

  	visit "/users/sign_in"

    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
		
		click_button "Entrar"
	end

  describe "user sign_in" do
	  it "allows users to sign in after they have registered" do
			logar

	    expect(page).to have_content("Login efetuado com sucesso!")
	  end
	end

	describe "user sign up" do
  	it "register an user" do
      visit new_user_registration_path
      #visit "/users/sign_up"

	    expect{
	      fill_in "Nome", with: "Ana"
	      fill_in "Email", with: Faker::Internet.email
	      fill_in "Senha", with: "anabanana"
	      fill_in "Confirmação de senha", with: "anabanana"

	      click_button "Criar conta"
	    }.to change(User,:count).by(1)

      expect(page).to have_content("Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail.")
      expect(page).to have_content("Últimos eventos")
      expect(page).to have_content("Navegar por categorias")
    end
  end

  describe "user update" do
  	it "allows users to edit their profile" do
  		logar
	    
	    visit "/events"

	    click_link('Editar perfil', match: :first)

	    within 'h2' do
	    	expect(page).to have_content("Edit User")
	    end

	    fill_in "Nome", with: "Ana Florin"
	    fill_in "Current password", with: @user.password

	    click_button "Update"
    	
      expect(page).to have_content("Sua conta foi atualizada com sucesso.")
    end
  end

end
