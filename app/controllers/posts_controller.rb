class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)

  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt)
  end

  def gpt_creation(post)

  end
end
