class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :asc)
    @current_user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @comments = @post.recent_comments
    @comment = Comment.new
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

 
  def like
    @post = Post.find(params[:id])
    @user = @post.author
    @like = Like.new(author_id: @user.id, post_id: @post.id)
    @like.save
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end
    

  def create
    puts current_user.inspect
    @post = Post.new(post_params)
    @post.author_id = current_user.id
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
