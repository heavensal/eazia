class Post < ApplicationRecord
  belongs_to :user
  has_one :gpt_creation, dependent: :destroy
  has_many :dalle3_images, dependent: :destroy
  has_many_attached :photos,
    after_add: :broadcast_photos

  validates :prompt, presence: :true
  validates :pictures_generated, inclusion: { in: 0..5 }

  def broadcast_photos
    broadcast_update_to(
      "post_#{self.id}",
      target: "photos",
      partial: "posts/photos",
      locals: { post: self }
    )
  end
end
