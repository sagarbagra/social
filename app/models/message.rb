class Message < ApplicationRecord
  belongs_to :conversation, optional: true
  belongs_to :user, optional: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end