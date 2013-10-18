class RecipientMailer < ActionMailer::Base
  default from: "Doug@soonmine.com"

  def two_week_reminder(reminder)
    soonminer = reminder.user.fullname
    mail(to: reminder.recipient_email, subject:"#{soonminer} has a #{reminder.name} coming up!)")
  end
end