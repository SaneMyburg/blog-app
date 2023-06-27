class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, author: :comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.recent_comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(current_user, @post), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
