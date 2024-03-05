class PhotosController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    AddphotoJob.perform_later(@post.id)
    redirect_to post_path(@post)
  end

  def load_my_photo
    @post = Post.find(params[:post_id])
    if params[:post][:photos]
      params[:post][:photos].each do |photo|
        filename = "image_#{Time.now.to_i}.jpeg"
        @post.photos.attach(photo)
        select_photos(@post)
      end
    end
    redirect_to post_path(@post)
  end

  def select
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    if @photo.id.in?(@post.photos_selected)
      @post.photos_selected.delete(@photo.id)
    else
      @post.photos_selected << @photo.id
    end
    @post.save!
    redirect_to post_path(@post), status: :see_other
  end

  def destroy
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    @post.photos_selected.delete(@photo.id)
    @post.save!
    @photo.purge
    # @post.dalle3_images.all.last.destroy
    redirect_to post_path(@post), status: :see_other
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
