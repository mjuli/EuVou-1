class UserController < ApplicationController
  def show
  	event = [{title: :Evento1, description: :Testestestestes, image: "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg"},
  					 {title: :Evento2, description: :Testestesteste2, image: "https://static.cineclick.com.br/sites/adm/uploads/banco_imagens/31/602x0_1439644246.jpg"}]
  	users = [{name: :Luan1, email: "luan1.goncbs@gmail.com", password: :password1, events: event}, 
  					 {name: :Luan2, email: "luan2.goncbs@gmail.com", password: :password2, events: event}, 
  					 {name: :Luan3, email: "luan3.goncbs@gmail.com", password: :password3, events: event}]
  	@user = users[params[:id].to_i-1]
  end

  def login
  end

  def cadastro
  end

  def edit
  end
end
