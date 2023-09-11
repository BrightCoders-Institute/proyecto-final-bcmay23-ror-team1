require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:ivan)
  end

  test "render notifications list" do
    get notifications_path
    assert_response :success
  end

  test "should mark notification as read and redirect to like" do
    notification = notifications(:unread_like_notification)
    put notification_path(notification)
    assert_redirected_to like_path(notification.notifiable)
    assert notification.reload.read
  end

  test "should mark notification as read and redirect to post" do
    notification = notifications(:unread_post_notification)
    put notification_path(notification)
    assert_redirected_to post_path(notification.notifiable)
    assert notification.reload.read
  end

  test "should mark notification as read and redirect to the follower" do
    notification = notifications(:unread_follow_notification)
    put notification_path(notification)
    assert_redirected_to user_path(notification.notifiable.follower)
    assert notification.reload.read
  end

  test "should mark notification as read and redirect to shared post" do
    notification = notifications(:unread_shared_post_notification)
    put notification_path(notification)
    assert_redirected_to post_path(notification.notifiable.post)
    assert notification.reload.read
  end

end
