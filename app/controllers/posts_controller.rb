class PostsController < ApplicationController

  def drafts
    @posts = Post.includes(:gpt_creation).where(user: current_user).order(created_at: :desc).with_attached_photos
  end

  def new
    @post = Post.new
  end

  require 'timeout'
  def create
    begin
      Timeout::timeout(29) do
        @post = Post.new(new_post_params)
        @post.user = current_user
        AiApiService.new(@post.user).work_1(@post) # Creation de la réponse de l'IA
        GptCreation.create_description(@post) # Creation de la description du post
        select_new_photos(@post)
        redirect_to post_path(@post)
      end
      PhotoJob.perform_later(@post.id)
    rescue => e
      logger.error "Une erreur s'est produite : #{e.message}"
      redirect_to new_post_path, alert: "Suite à une erreur de l'IA, votre post n'a pas été créé. Merci de réessayer ultérieurement."
    end
  end

  def show
    @post = Post.includes(:gpt_creation).with_attached_photos.find(params[:id])
    @photos = @post.photos
    @photos_selected = @post.photos_selected.map do |id|
      @post.photos.where(id: @post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact # j'assigne les photos sélectionnées à une variable
    @gpt_creation = @post.gpt_creation
    @description = @post.gpt_creation.description # description du post
  end

  def publish
    @post = Post.find(params[:id])
    begin
      FbApiService.new(@post.user).publish(@post)
      if @post.update(status: "published")
        redirect_to new_post_path, notice: "Votre post a été publié avec succès"
      else
        redirect_to post_path(@post), alert: "Suite à une erreur, votre post n'a pas été publié"
      end
    rescue
      redirect_to post_path(@post), alert: "Suite à une erreur, votre post n'a pas été publié"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to drafts_path, status: :see_other, notice: "Votre post a été supprimé avec succès."
    else
      redirect_to post_path(@post), status: :unprocessable_entity, alert: "Suite à une erreur, votre post n'a pas été supprimé."
    end
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt, :description, :pictures_generated, photos: [])
  end

  def select_new_photos(post)
    unless post.photos.empty?
      post.photos.each do |photo|
        post.photos_selected << photo.id
      end
    end
    return if post.save
  end

end
