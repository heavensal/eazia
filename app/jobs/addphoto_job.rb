class AddphotoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    broadcast_loading_photo(post)
    AiApiService.new(post.user).image(post)
    select_photos(post)
    broadcast_one_photo(post)
  end

  private

  def broadcast_loading_photo(post, i = 0)
    Turbo::StreamsChannel.broadcast_before_to post,
        target: "create-load-photo",
        partial: "photos/loading-photo",
        local: { i: i }
  end

  def select_photos(post)
    post.photos_selected << post.photos.last.id
    post.save!
  end

  def broadcast_one_photo(post)
    photos_selected = post.photos_selected.map do |id|
      post.photos.where(id: post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact
    Turbo::StreamsChannel.broadcast_replace_to post,
        target: "loading-photo_0",
        partial: "photos/show-photo",
        locals: { photo: post.photos.last, post: post }
    Turbo::StreamsChannel.broadcast_update_to post,
        target: "myCarousel",
        partial: "photos/insta-photos",
        locals: { photos_selected: photos_selected, post: post }
  end
end
