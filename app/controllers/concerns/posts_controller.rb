class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    @post.user = current_user
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work(@post)
    GptCreation.create_description(@post) # Creation de la description du post
    ai_api_service.image(@post) # Creation d'une image Dall-E
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @images = @post.photos
    @description = @post.gpt_creation.description
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt, photos: [])
  end

end
