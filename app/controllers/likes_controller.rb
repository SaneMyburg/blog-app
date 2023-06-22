class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @user = @post.author
    @like = Like.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      redirect_to user_post_path(user_id: @user.id, id: @post.id), notice: 'Post liked successfully.'
    else
      redirect_to user_post_path(user_id: @user.id, id: @post.id), alert: 'Failed to like the post.'
    end
  end
end
