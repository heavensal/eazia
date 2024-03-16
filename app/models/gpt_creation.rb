class GptCreation < ApplicationRecord
  belongs_to :post

  before_create :consume_token

  def self.create_description(post)
    description = extract(post)
    create(description: description, post: post)
  end

  def consume_token
    self.post.user.wallet.tokens -= 1
    self.post.user.wallet.save
  end

  private

  def self.extract(post)
    post.description[/_%(.+?)%_/, 1]
  end
end
