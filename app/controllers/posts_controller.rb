class PostsController < ApplicationController
  def drafts
    @posts = Post.includes(:gpt_creation).where(user: current_user, status: "draft").order(created_at: :desc).with_attached_photos
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    @post.user = current_user
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work_1(@post)
    GptCreation.create_description(@post) # Creation de la description du post
    @post.pictures_generated.times do
      ai_api_service.image(@post) # Creation d'une image Dall-E
    end
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @images = @post.photos
    @description = @post.gpt_creation.description
  end

  def update
    @post = Post.find(params[:id])
    new_description = params[:post][:description]
    @post.description = new_description
    if @post.save
      redirect_to post_path(@post)
    else
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt, :description, :pictures_generated, photos: [])
  end

end
