class Post < ApplicationRecord
  belongs_to :user
  has_one :gpt_creation, dependent: :destroy
  has_many :dalle3_images, dependent: :destroy
end
