class GptCreation < ApplicationRecord
  belongs_to :post

  def self.create_description(post)
    description = extract(post)
    create(description: description, post: post)
  end

  private

  def self.extract(post)
    post.description[/_%(.+?)%_/, 1]
  end
end
