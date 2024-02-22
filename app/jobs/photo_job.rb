class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      photo = ai_api_service.image(post)
      Turbo::StreamsChannel.broadcast_append_to "post_#{post_id}",
                                                  target: "photos",
                                                  partial: "posts/photo",
                                                  locals: { photo: post.photos.last }
      Turbo::StreamsChannel.broadcast_update_to "post_#{post_id}", target: "myCarousel",
                                                  partial: "posts/insta-photos",
                                                  locals: { images: post.photos }
    end
  end
end
