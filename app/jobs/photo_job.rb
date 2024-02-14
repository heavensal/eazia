class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      photo = ai_api_service.image(post)
      # broadcast_update_to(
      # "post_#{post.id}",
      # target: "photos",
      # partial: "posts/photos",
      # locals: { post: post }
      # )
      # broadcast_update_later_to(
      # "post_#{self.id}",
      # target: "insta-photos",
      # partial: "posts/insta-photos",
      # locals: { images: self.photos }
      # )
    end
  end
end
