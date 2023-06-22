class CommentsController < ApplicationController
  def new
    @post = @current_user.posts.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
