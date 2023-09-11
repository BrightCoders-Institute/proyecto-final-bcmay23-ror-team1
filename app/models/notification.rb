class Notification < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'

  belongs_to :notifiable, polymorphic: true

  def mark_as_read
    if self.read == false
      update(read: true)
    end
  end
  
end
