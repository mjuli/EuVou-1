class UserController < ApplicationController
  def show
  	events = [{title: :Evento1, description: :Testestestestes, image: "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg"},
  					 {title: :Evento2, description: :Testestesteste2, image: "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg"}]
  	users = [{name: :Luan1, email: "luan1.goncbs@gmail.com", password: :password1, events: events}, 
  					 {name: :Luan2, email: "luan2.goncbs@gmail.com", password: :password2, events: events}, 
  					 {name: :Luan3, email: "luan3.goncbs@gmail.com", password: :password3, events: events}]
  	@user = users[params[:id].to_i-1]
  end

  def login
    #seesion[:current_user] = "token"
  end

  def logoff
    #seesion[:current_user] = nil
  end

  def cadastro
  end

  def edit
    #RestClient.put ("https://euvouapi.herokuapp.com/users/" + session[:current_user], {:user => params}.json)
  end

  def create

    #RestClient.post ("https://euvouapi.herokuapp.com/users", {:user => params}.json)
    respond_to do |format|
      format.html { redirect_to "/login", notice: 'Cadastro realizado com sucesso!' }
    end
  end

end
