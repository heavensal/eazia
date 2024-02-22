class Post < ApplicationRecord
  broadcasts_refreshes
  belongs_to :user
  has_one :gpt_creation, dependent: :destroy
  has_many :dalle3_images, dependent: :destroy
  has_many_attached :photos
  # after_update_commit :broadcast_photos

  validates :prompt, presence: :true
  validates :pictures_generated, inclusion: { in: 0..5 }

  # def broadcast_photos
  #   html_content = ApplicationController.renderer.render(
  #     partial: "posts/photos",
  #     locals: { post: self }
  #   )

  #   # Diffuse le contenu HTML généré au canal approprié
  #   PostChannel.broadcast_to(self, html_content)
  # end

  # def broadcast_photos
  #   # photos = render_to_string(partial: "posts/photos", locals: {post: self}).to_s
  #   broadcast_update_to(
  #     self,
  #     target: "photos",
  #     partial: "posts/photos", locals: {post: self}
  #     )
  #   # carousel = render_to_string(partial: "posts/insta-photos", locals: {post: self}).to_s
  #   broadcast_update_to(
  #     self,
  #     target: "insta-photos",
  #     partial: "posts/insta-photos", locals: {post: self}
  #   )
  # end
end
