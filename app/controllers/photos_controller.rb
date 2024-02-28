class PhotosController < ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    @photo = @post.photos.find(params[:id])
    @photo.purge
    redirect_to post_path(@post), status: :see_other
  end
end
