class CustomerSideMailer < ApplicationMailer

  def order_secret_code_mail(email, code)
    email_id = email
    @code = code
    subject = 'Your Secret Code For Sign Up'
    mail(to: email_id, subject: subject)
  end

end
