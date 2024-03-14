class AddphotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    ai_api_service = AiApiService.new(post.user)
    photo = ai_api_service.image(post)
    select_photos(post)
    broadcast_photos(post)
  end

  def broadcast_photos(post)
    photos_selected = post.photos_selected.map do |id|
      post.photos.where(id: post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact
    Turbo::StreamsChannel.broadcast_append_to post,
        target: "photos",
        partial: "photos/show-photo",
        locals: { photo: post.photos.last, post: post }
    Turbo::StreamsChannel.broadcast_update_to post,
        target: "myCarousel",
        partial: "photos/insta-photos",
        locals: { photos_selected: photos_selected, post: post }
  end

  def select_photos(post)
    post.photos_selected << post.photos.last.id
    post.save!
  end
end
