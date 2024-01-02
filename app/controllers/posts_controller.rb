class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create

  end

  def show
    @post = Post.find(params[:id])
  end

  def gpt_creation

  end
end
