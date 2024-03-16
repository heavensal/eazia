class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do |i|
      broadcast_loading_photo(post, i)
      ai_api_service.image(post)
      select_photos(post)
      broadcast_photos(post, i)
    end
  end

  private

  def broadcast_loading_photo(post, i)
    Turbo::StreamsChannel.broadcast_before_to post,
        target: "btn-create-load-photo",
        partial: "photos/loading-photo",
        locals: { i: i }
  end

  def select_photos(post)
    post.photos_selected << post.photos.last.id
    post.save!
  end

  def broadcast_photos(post, i)
    photos_selected = post.photos_selected.map do |id|
      post.photos.where(id: post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact
    Turbo::StreamsChannel.broadcast_replace_to post,
        target: "loading-photo_#{i}",
        partial: "photos/show-photo",
        locals: { photo: post.photos.last, post: post }
    Turbo::StreamsChannel.broadcast_update_to post,
        target: "myCarousel",
        partial: "photos/insta-photos",
        locals: { photos_selected: photos_selected, post: post }
  end
end
