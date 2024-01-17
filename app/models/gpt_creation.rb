class GptCreation < ApplicationRecord
  belongs_to :post

  def self.create_description(post)
    description = extract(post)
    create(description: description, post: post)
    post.update(description: description)
  end

  def self.regenerate_description(post)
    # Logique spécifique pour régénérer la description
    nouvelle_description = generate_new_description(post)
    post.update(description: nouvelle_description)
  end

  private

    def self.extract(post)
      post.description[/_%(.+?)%_/, 1]
    end

  def self.generate_new_description(post)
    # Logique pour générer une nouvelle description
    post.description[/_%(.+?)%_/, 1]
  end
end
