require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  test "Should not save blank notification" do
    notification = Notification.new
    assert_not notification.save
  end

  test "Should save notification with read field as false" do

    sender = users(:ivan)
    receiver = users(:moises)
    like = Like.first

    notification = Notification.new(sender: sender, receiver: receiver, notifiable: like)

    assert_equal(notification.read, false)
    assert notification.save
    
  end

  test "should mark notification as read" do
    notification = notifications(:unread_like_notification)
    assert_not notification.read

    notification.mark_as_read
    assert notification.read
  end

end
