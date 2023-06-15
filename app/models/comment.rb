class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  # validates :text, presence: true

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
