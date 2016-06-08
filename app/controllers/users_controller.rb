class UsersController < ApplicationController
  before_action  :set_user, :finish_signup

   def index
     @users = User.find.all
   end

  def finish_signup
    if request.patch? && params[:user] 
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
				redirect_to root_path, notice: 'Perfil atualizado com sucesso.'
      else
        @show_errors = true
      end
    end
  end

	def user_show
		@user = User.find(params[:id])
		@previous_events = @user.previous_events
		@upcoming_events = @user.upcoming_events
	end
	
  private
    def set_user
      @user = User.find(params[:id])
    end


    def user_params
			accessible = [ :name, :email, :remeber_me, :image, :image_cache ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

end