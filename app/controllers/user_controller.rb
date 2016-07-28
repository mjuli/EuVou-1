class UserController < ApplicationController
  
  #GET
  def show
  	user = RestClient.get 'https://euvouapi.herokuapp.com/users/' + params[:id]
    @user = JSON.parse(user).symbolize_keys
    @user = @user[:data]["attributes"]
  end

  #GET
  def login
    #seesion[:current_user] = "token"
  end

  def logoff
    #seesion[:current_user] = nil
  end

  #POST
  def singin
    token = RestClient.post 'http://euvouapi.herokuapp.com/oauth/token', {"email" => params["email"], "password" => params["senha"], "grant_type" => "password"}
    session[:current_user] = JSON.parse(token).symbolize_keys
    respond_to do |format|
      format.html { redirect_to '/event', notice: 'Seja bem vindo' }
    end
  end

  #GET ou POST
  def singout
    session[:current_user] = nil
    respond_to do |format|
      format.html { redirect_to '/event', notice: 'Até mais!!' }
    end
  end

  #GET
  def cadastro
  end
  
  #POST
  def create
    begin
      RestClient.post 'euvouapi.herokuapp.com/registrations', {"user" => {"name" => params["nome"], "email" => params["email"], "password" => params["senha"], "password_confirmation" => params["senhaconfirm"]}}
    rescue => e
      response = e.response
      respond_to do |format|
        format.html { redirect_to login_url, notice: 'Oops! Algum erro ocorreu. Tente novamente' }
      end
      return
    end
    
    respond_to do |format|
      format.html { redirect_to login_url, notice: 'Usuário criado com sucesso' }
    end
    
  end

  #PUT
  def edit
    
  end

end
