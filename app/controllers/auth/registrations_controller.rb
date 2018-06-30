class Auth::RegistrationsController < Devise::RegistrationsController
  def new
    @email = session[:secret_email]
    super
  end
  def create
    code = SecretCode.find_by_code(params[:user][:secret_code])
    if code.present?
      if code.email == params[:user][:email]
        super
        code.update_attribute(:user_id, current_user.id)
      else
        flash.now[:alert] = 'Secret Code and Email Not Matched'
        redirect_to new_registration_path(resource_name)
      end
    else
      flash.now[:alert] = 'Wrong Secret Code Entered'
      render 'auth/send_secret_code_form'
    end
  end
end
