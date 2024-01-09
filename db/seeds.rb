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
#   thread_creator = Faraday.new(
#     url: 'https://api.openai.com/v1/threads',
#     headers: {'Content-Type' => 'application/json',
#               'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
#               'OpenAI-Beta' => 'assistants=v1'}
#   )

#   response = thread_creator.post
#   response_body = response.body

# # Parsing du JSON pour le convertir en Hash
# parsed_response = JSON.parse(response_body)

# # Récupération du thread_id
# thread_id = parsed_response["id"]

# puts "Thread ID: #{thread_id}"

leila = User.last
# p leila
# puts leila.thread

# liste des messages

# disp_message = Faraday.new(
#                 url: "https://api.openai.com/v1/threads/#{leila.thread}/messages",
#                 headers: {'Content-Type' => 'application/json',
#                           'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
#                           'OpenAI-Beta' => 'assistants=v1'}
#               )
# response = disp_message.get
# body = JSON.parse(response.body)
# data = body['data']
# data.each do |msg|
#   puts " "
#   puts "auteur -> " + msg['role']
#   puts "said -> " + msg['content'][0]['text']['value']
#   puts " "
#   puts " "
# end

request = Faraday.new(
      url: "https://api.openai.com/v1/threads/#{leila.thread}/messages",
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                'OpenAI-Beta' => 'assistants=v1'},
      )
    response = request.get
    data = JSON.parse(response.body)
    result = data['data'][0]["content"][0]["text"]["value"]

puts result

post = Post.last
# p post
puts " "
# post.update!(description: result)
post.description = result[/_%(.+?)%_/, 1]
# post.description = matched
post.save!
puts "Voici la description Dall-E de mon post -> " + post.description
