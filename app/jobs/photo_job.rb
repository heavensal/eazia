class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      photo = ai_api_service.image(post)
    end
  end
end
