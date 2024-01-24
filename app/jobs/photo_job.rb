class PhotoJob < ApplicationJob
  queue_as :default

  def perform(post)
    ai_api_service = AiApiService.new(post.user)
    post.pictures_generated.times do
      photo = ai_api_service.image(post) # Retourne la nouvelle photo attachée

      # Diffuser le Turbo Stream pour ajouter l'image à la vue
      Turbo::StreamsChannel.broadcast_append_to(
        post,
        target: "images",
        partial: "posts/image",
        locals: { photo: photo }
      )
    end
  end
end
