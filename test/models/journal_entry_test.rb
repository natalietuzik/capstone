require "test_helper"

class JournalEntryTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "journal@example.com", password: "password123")
    @entry = JournalEntry.new(user: @user, title: "My First Entry", date: Date.today)
  end

  test "valid journal entry" do
    assert @entry.valid?
  end

  test "title must be present" do
    @entry.title = ""
    assert_not @entry.valid?
  end

  test "date must be present" do
    @entry.date = nil
    assert_not @entry.valid?
  end

  test "body is optional" do
    @entry.body = nil
    assert @entry.valid?
  end

  test "belongs to user" do
    assert_equal @user, @entry.user
  end

  test "ordered scope sorts by date descending" do
    older = JournalEntry.create!(user: @user, title: "Old Entry", date: Date.today - 5)
    newer = JournalEntry.create!(user: @user, title: "New Entry", date: Date.today)
    assert_equal newer, JournalEntry.ordered.first
  end
end
