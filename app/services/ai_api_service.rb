class AiApiService
  def initialize(user)
    @user = user
    @api_key = ENV['GPT_ANAIS']
  end

  def prompt(post)
    # Logique pour envoyer un prompt
  end

  def run_thread(post)
    # Logique pour exécuter le thread
  end

  def get_answer(post)
    # Logique pour obtenir la réponse
  end

  # Autres méthodes nécessaires...

  private

  def faraday_client
    Faraday.new(headers: {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@api_key}"})
  end
end
