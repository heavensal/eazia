class PhotosController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    AddphotoJob.perform_later(@post.id)
  end

  def load_my_photo
    @post = Post.find(params[:post_id])
    if params[:post][:photos].present?
      params[:post][:photos].each do |photo|
        filename = "image_#{Time.now.to_i}.jpeg"
        @post.photos.attach(photo)
      end
    end
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), status: :unprocessable_entity, alert: 'Erreur lors de l\'ajout de la photo. Merci de réessayer.'
    end
  end

  def select
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    if @photo.id.in?(@post.photos_selected)
      @post.photos_selected.delete(@photo.id)
      @post.save ? (redirect_to post_path(@post)) : (redirect_to post_path(@post), status: :unprocessable_entity, alert: 'Erreur lors de la désélection de la photo. Merci de réessayer.')
    else
      @post.photos_selected << @photo.id
      @post.save ? (redirect_to post_path(@post)) : (redirect_to post_path(@post), status: :unprocessable_entity, alert: 'Erreur lors de la sélection de la photo. Merci de réessayer.')
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    @post.photos_selected.delete(@photo.id)
    if @post.save && @photo.purge
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), status: :unprocessable_entity, alert: 'Erreur lors de la suppression de la photo. Merci de réessayer.'
    # @post.dalle3_images.all.last.destroy
    end
  end

  private

  def photo_params
    params.require(:post).permit(photos: [])
  end

  def select_new_photo(post)
    post.photos_selected << post.photos.last.id
  end

end
