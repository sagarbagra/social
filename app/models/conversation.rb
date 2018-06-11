class Conversation < ApplicationRecord
	 belongs_to :sender, :foreign_key => :sender_id, :class_name => "User"
 	 belongs_to :recipient, :foreign_key => :receiver_id, :class_name => "User"
	has_many :messages, dependent: :destroy


	def opposed_user(user)
   		 user == recipient ? sender : recipient
  	end

end
