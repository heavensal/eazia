# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  # creation d'une conversation entre un USER et CHATGPT
  thread_creator = Faraday.new(
    url: 'https://api.openai.com/v1/threads',
    headers: {'Content-Type' => 'application/json',
              'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
              'OpenAI-Beta' => 'assistants=v1'}
  )

  response = thread_creator.post
  response_body = response.body

# Parsing du JSON pour le convertir en Hash
parsed_response = JSON.parse(response_body)

# Récupération du thread_id
thread_id = parsed_response["id"]

puts "Thread ID: #{thread_id}"
