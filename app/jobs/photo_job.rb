class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      photo = ai_api_service.image(post)
      Turbo::StreamsChannel.broadcast_replace_to "post_#{post.id}",
        target: "photos", # ID l'élément HTML à mettre à jour
        partial: "posts/photos", # Le partial qui contient les nouvelles infos
        locals: { post: post }
    end
  end
end
