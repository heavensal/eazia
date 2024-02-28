class PhotosController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    AddphotoJob.perform_later(@post.id)
    redirect_to post_path(@post)
  end

  def load_my_photo
    @post = Post.find(params[:post_id])
    if params[:post] && params[:post][:photos]
      params[:post][:photos].each do |photo|
        @post.photos.attach(photo)
      end
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    @photo.purge
    # @post.dalle3_images.all.last.destroy
    redirect_to post_path(@post), status: :see_other
  end

  def photo_params
    params.require(:post).permit(photos: [:photos])
  end
end
