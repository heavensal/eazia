class GptCreation < ApplicationRecord
  belongs_to :post

  before_create :consume_wallet

  # validates :description, presence: true, length: { maximum: 2200 }

  def self.create_description(post)
    description = extract(post)
    create(description: description, post: post)
  end

  def consume_wallet
    self.post.user.remove_gold(1)
  end

  private

  def self.extract(post)
    post.description[/_%(.+?)%_/, 1]
  end
end
