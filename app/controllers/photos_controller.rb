class PhotosController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    AddphotoJob.perform_later(@post.id)
    redirect_to post_path(@post), notice: 'Photo en cours de création. Merci de patienter quelques instants.'
  end

  def load_my_photo
    @post = Post.find(params[:post_id])
    if photo_params[:photos].present?
      photo_params[:photos].each do |photo|
        filename = "image_#{Time.now.to_i}.jpeg"
        @post.photos.attach(photo)
        select_photos(@post)
      end
    end
    redirect_to post_path(@post), notice: 'Photo ajoutée avec succès.'
  end

  def select
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    if @photo.id.in?(@post.photos_selected)
      @post.photos_selected.delete(@photo.id)
      @post.save ? (redirect_to post_path(@post), notice: 'Photo enlevée avec succès.') : (redirect_to post_path(@post), status: :unprocessable_entity, notice: 'Erreur lors de la désélection de la photo. Merci de réessayer.')
    else
      @post.photos_selected << @photo.id
      @post.save ? (redirect_to post_path(@post), notice: 'Photo sélectionnée avec succès.') : (redirect_to post_path(@post), status: :unprocessable_entity, notice: 'Erreur lors de la sélection de la photo. Merci de réessayer.')
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    @post.photos_selected.delete(@photo.id)
    @post.save!
    @photo.purge
    # @post.dalle3_images.all.last.destroy
    redirect_to post_path(@post), notice: 'Photo supprimée avec succès.'
  end


  private

  def photo_params
    params.require(:post).permit(photos: [])
  end

  def select_photos(post)
    post.photos_selected << post.photos.last.id
    post.save!
  end
end
