class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  validates :text, presence: true

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
