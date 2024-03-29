class UserMailer < ActionMailer::Base
  default from: "Doug@soonmine.com"


  def welcome_email(user)
    @user = user
    if @user.email
      mail(to: @user.email, subject: "Welcome to Soonmine")
    end
  end
end
