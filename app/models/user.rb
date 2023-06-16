class User < ActiveRecord::Base
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.recent_posts(user)
    user.posts.order(created_at: :desc).limit(4)
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
