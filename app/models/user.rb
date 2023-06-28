class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, class_name: 'Post', foreign_key: :author_id
  has_many :comments, class_name: 'Comment', foreign_key: :author_id
  has_many :likes, class_name: 'Like', foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.recent_posts(user)
    user.posts.order(created_at: :asc).limit(3)
  end

  def posts_counter
    posts.count
  end

  def self.display_user_info(user)
    if user
      puts "User ID: #{user.id}"
      puts "Name: #{user.name}"
      puts "Bio: #{user.bio}"
    else
      puts 'User not found.'
    end
  end
end
