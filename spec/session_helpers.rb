module SessionHelpers
  def logar
    @user = FactoryGirl.create(:user)
    @user.confirm 

    visit "/users/sign_in"

    fill_in "Email",    :with => @user.email
    fill_in "Password", :with => @user.password
    
    click_button "Entrar"
  end
  
  def logar_user(user)
    user.confirm 

    visit "/users/sign_in"

    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    
    click_button "Entrar"
  end

  def criar_evento
    category = FactoryGirl.create(:category)
    @event = FactoryGirl.create(:event, title: "Casa de praia", user_id: @user.id, category_id: category.id, date: Time.new(2016, 7, 7))
    address = FactoryGirl.create(:address, event_id: @event.id)
  end
end
