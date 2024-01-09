class Dalle3Image < ApplicationRecord
  belongs_to :post

  after_create :add_photo

  def add_photo
    require "open-uri"
    file = URI.open(link)
    post.photos.attach(io: file, filename: "#{prompt.chars.sample(10).join}.png", content_type: "image/png")
    post.save!
  end
end
