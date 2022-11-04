class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
git 