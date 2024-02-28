class AddphotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    ai_api_service = AiApiService.new(post.user)
    photo = ai_api_service.image(post)
    broadcast_photos(post)
  end

  def broadcast_photos(post)
    Turbo::StreamsChannel.broadcast_append_to "post_#{post.id}",
        target: "photos",
        partial: "posts/photo",
        locals: { photo: post.photos.last, post: post }
    Turbo::StreamsChannel.broadcast_update_to "post_#{post.id}",
        target: "myCarousel",
        partial: "posts/insta-photos",
        locals: { images: post.photos }
  end
end
