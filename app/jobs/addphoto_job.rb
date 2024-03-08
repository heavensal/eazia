class AddphotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    ai_api_service = AiApiService.new(post.user)
    photo = ai_api_service.image(post)
    broadcast_photos(post)
    select_photos(post)
  end

  def broadcast_photos(post)
    Turbo::StreamsChannel.broadcast_append_to post,
        target: "photos",
        partial: "posts/photo",
        locals: { photo: post.photos.last, post: post }
    Turbo::StreamsChannel.broadcast_update_to post,
        target: "myCarousel",
        partial: "posts/insta-photos",
        locals: { images: post.photos, post: post }
  end

  def select_photos(post)
    post.photos_selected << post.photos.last.id
    post.save!
  end
end
