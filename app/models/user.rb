class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :posts, dependent: :destroy 
         has_many :comments, dependent: :destroy 
         has_many :likes, dependent: :destroy 
         has_many :friendships,dependent: :destroy
         has_many :friends, through: :friendships,:source => :user 
         has_many :inverse_friendships, :class_name => "Friendship" ,:foreign_key =>"friend_id"
         has_many :inverse_friends,:through => :inverse_friendships,:source => :user  
         has_many :conversations   
         has_many :messages,  through: :conversations         
         mount_uploader :image, AvatarUploader
end
