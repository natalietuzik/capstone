class ReminderMailer < ApplicationMailer
  def daily_reminder(user, tasks)
    @user = user
    @tasks = tasks
    @tomorrow = Date.tomorrow
    mail(to: @user.email, subject: "☀️ Brighter Day — Your tasks for #{@tomorrow.strftime('%A, %B %d')}")
  end
end
