class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
end
=======
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Send 'em back where they came from with a slap on the wrist
  def authority_forbidden(error)
    Authority.logger.warn(error.message)
    redirect_to request.referrer.presence || root_path, :alert => 'Você não tem autorização para realizar essa ação.'
  end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end


  protected

  def configure_permitted_parameters
    #deprecated
    #devise_parameter_sanitizer.for(:sign_up) << [:name, :image]
    #devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
>>>>>>> 5776b68ca67f0d4680e8957ed75b7e0b1777bd00
