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
    select_photos(@post)
    redirect_to post_path(@post)
    PhotoJob.perform_later(@post.id)
  end

  def show
    @post = Post.includes(:gpt_creation).with_attached_photos.find(params[:id])
    @photos = @post.photos
    photos_selected = @post.photos.where(id: @post.photos_selected)
    @photos_selected = @post.photos_selected.map do |id|
      photos_selected.detect { |photo| photo.id == id.to_i }
    end.compact
    @gpt_creation = @post.gpt_creation
    @description = @post.gpt_creation.description
    logger.info(@description)
  end

  def publish
    @post = Post.find(params[:id])
    # la je teste avec plusieurs photo, ca doit faire un carrousel
    FbApiService.new(@post.user).carrousel(@post)
    @post.update!(status: "published")
    redirect_to new_post_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to drafts_path, status: :see_other
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt, :description, :pictures_generated, photos: [])
  end

  def select_photos(post)
    unless post.photos.empty?
      post.photos.each do |photo|
        post.photos_selected << photo.id
      end
    end
    return if post.save
  end

end
