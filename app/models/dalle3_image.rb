class Dalle3Image < ApplicationRecord
  require 'open-uri'
  belongs_to :post

  before_create :consume_token
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

  def consume_token
    self.post.user.wallet.remove_tokens(1)
  end
end
