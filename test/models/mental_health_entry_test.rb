require "test_helper"

class MentalHealthEntryTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "wellness@example.com", password: "password123")
    @entry = MentalHealthEntry.new(user: @user, date: Date.today, mood: 7, anxiety: 4)
  end

  test "valid entry" do
    assert @entry.valid?
  end

  test "date must be present" do
    @entry.date = nil
    assert_not @entry.valid?
  end

  test "mood must be present" do
    @entry.mood = nil
    assert_not @entry.valid?
  end

  test "anxiety must be present" do
    @entry.anxiety = nil
    assert_not @entry.valid?
  end

  test "mood must be between 1 and 10" do
    @entry.mood = 0
    assert_not @entry.valid?
    @entry.mood = 11
    assert_not @entry.valid?
    @entry.mood = 5
    assert @entry.valid?
  end

  test "anxiety must be between 1 and 10" do
    @entry.anxiety = 0
    assert_not @entry.valid?
    @entry.anxiety = 11
    assert_not @entry.valid?
    @entry.anxiety = 5
    assert @entry.valid?
  end

  test "one entry per user per date" do
    @entry.save!
    duplicate = MentalHealthEntry.new(user: @user, date: Date.today, mood: 5, anxiety: 3)
    assert_not duplicate.valid?
  end
end
