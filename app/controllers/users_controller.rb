class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = User.recent_posts(@user)
    @posts_count = @user.posts_counter
  end
end
# @user = User.includes(posts: :comments).find(params[:id])