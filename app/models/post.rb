class Post < ApplicationRecord
  broadcasts_refreshes
  belongs_to :user
  has_one :gpt_creation, dependent: :destroy
  has_many :dalle3_images, dependent: :destroy
  has_many_attached :photos

  validates :prompt, presence: :true
  validates :pictures_generated, inclusion: { in: 0..5 }
end
