require "test_helper"

class TodoItemTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "todo@example.com", password: "password123")
    @item = TodoItem.new(user: @user, title: "Buy groceries", priority: 2)
  end

  test "valid todo item" do
    assert @item.valid?
  end

  test "title must be present" do
    @item.title = ""
    assert_not @item.valid?
  end

  test "priority must be 1, 2, or 3" do
    @item.priority = 5
    assert_not @item.valid?
  end

  test "completed defaults to false" do
    item = TodoItem.create!(user: @user, title: "Test task", priority: 1)
    assert_equal false, item.completed
  end

  test "notes are optional" do
    @item.notes = nil
    assert @item.valid?
  end

  test "belongs to user" do
    assert_equal @user, @item.user
  end

  test "pending scope returns only incomplete items" do
    done = TodoItem.create!(user: @user, title: "Done task", priority: 2, completed: true)
    pending = TodoItem.create!(user: @user, title: "Pending task", priority: 2, completed: false)
    assert_includes TodoItem.pending, pending
    assert_not_includes TodoItem.pending, done
  end
end
