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
    redirect_to post_path(@post)
    PhotoJob.perform_later(@post.id)
  end

  def show
    @post = Post.includes(:gpt_creation).with_attached_photos.find(params[:id])
    @images = @post.photos
    @gpt_creation = @post.gpt_creation
    @description = @post.gpt_creation.description
  end

  def delete_photo
    @photo = ActiveStorage::Attachment.find(params[:photo_id])
    @photo.purge
    redirect_to :see_other
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

  def publish
    @post = Post.find(params[:id])
    fb_api_service = FbApiService.new(@post.user)
    fb_api_service.ig_account(@post.user)
    fb_api_service.publish(@post, fb_api_service.new_container(@post))
    @post.update!(status: "published")
    redirect_to new_post_path
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt, :description, :pictures_generated, photos: [])
  end

end
