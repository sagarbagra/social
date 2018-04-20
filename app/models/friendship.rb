class Friendship < ApplicationRecord
  belongs_to :user , inverse_of: :friendships
end
