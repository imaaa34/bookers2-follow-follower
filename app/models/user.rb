class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :followers, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followeds, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_users, through: :followed, source: :follower
  has_many :followed_users, through: :follower, source: :followed

  def follow(user_id)
    follower.create(follower_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(follower_id: user_id).destroy
  end

  def following?(user)
    followed_users.include?(user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
