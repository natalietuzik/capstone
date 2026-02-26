require "test_helper"

class PlannerItemTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "test@example.com", password: "password123")
    @item = PlannerItem.new(user: @user, title: "Morning Walk", date: Date.today)
  end

  test "valid planner item" do
    assert @item.valid?
  end

  test "title must be present" do
    @item.title = ""
    assert_not @item.valid?
  end

  test "date must be present" do
    @item.date = nil
    assert_not @item.valid?
  end

  test "completed defaults to false" do
    item = PlannerItem.create!(user: @user, title: "Test", date: Date.today)
    assert_equal false, item.completed
  end

  test "belongs to user" do
    assert_equal @user, @item.user
  end
end
