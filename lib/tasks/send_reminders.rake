task :mail => :environment do
  require './app/models/reminder.rb'
  recipieints = Reminder.where(date: 2.weeks.from_now)
  recipieints.each do |x|
    RecipientMailer.two_week_reminder(x).deliver
  end
end


# Reminder.create(name: "Michael's birthday reminder", date: 2.weeks.from_now)