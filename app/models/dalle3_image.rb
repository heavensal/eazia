class Dalle3Image < ApplicationRecord
  require 'open-uri'
  belongs_to :post

  after_create :add_photo

  def add_photo
    begin
      file = URI.open(link)
      filename = "image_#{Time.now.to_i}.jpeg"
      post.photos.attach(io: file, filename: filename, content_type: "image/jpeg")
    rescue => e
      Rails.logger.error "ECHEC LORS DE L'OPERATION: #{e.message}"
    end
  end
end
