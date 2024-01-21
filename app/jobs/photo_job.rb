class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      ai_api_service.image(post) # Creation d'une image Dall-E
    end
  end
end
