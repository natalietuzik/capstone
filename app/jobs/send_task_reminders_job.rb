class SendTaskRemindersJob < ApplicationJob
  queue_as :default

  def perform
    tomorrow = Date.tomorrow
    User.find_each do |user|
      tasks = user.planner_items.for_date(tomorrow).ordered.where(completed: false)
      next if tasks.empty?

      ReminderMailer.daily_reminder(user, tasks).deliver_later
    end
  end
end
