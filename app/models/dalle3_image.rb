class Dalle3Image < ApplicationRecord
  belongs_to :post

  after_create :add_photo

  def add_photo
    require "open-uri"
    file = URI.open(link)
    post.photos.attach(io: file, filename: "#{prompt.chars.sample(10).join}.jpeg", content_type: "image/jpeg")
    post.save!
    #   Turbo::StreamsChannel.broadcast_append_to(
    #   post,
    #   target: "photos",
    #   partial: "posts/photo",
    #   locals: { photo: post.photos.last }
    #   )
    # end
  end
end
