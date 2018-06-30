class Auth::AuthController < ApplicationController
  skip_before_action :authenticate_user! 

  def send_secret_code_form
    render 'auth/send_secret_code_form'
  end

  def send_secret_code
    resource_name = :user
    u = User.find_by_email(params[:secret_code][:email])
    if u.present?
      flash[:alert] = 'User alredy exixts'
      redirect_to new_user_session_path
    else
      email = session[:secret_email] = params[:secret_code][:email]
      secret_code = SecretCode.where('exp_time < ?', Time.now)
                              .or(SecretCode.where(exp_time: nil))
                              .where(user_id: nil).first
      if secret_code.present?
        secret_code.update_attributes(email: email, exp_time: Time.now+1.hour)
        CustomerSideMailer.order_secret_code_mail(email,secret_code.code).deliver_now
        redirect_to new_registration_path(resource_name)
      else
        flash.now[:alert] = 'No secret code available'
        render 'auth/send_secret_code_form'
      end
    end
  end

end
