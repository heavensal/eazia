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

# kazuya = User.last
# p kazuya
# puts kazuya.thread

# # liste des messages

# disp_message = Faraday.new(
#                 url: "https://api.openai.com/v1/threads/#{kazuya.thread}/messages",
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

# request = Faraday.new(
#       url: "https://api.openai.com/v1/threads/#{leila.thread}/messages",
#       headers: {'Content-Type' => 'application/json',
#                 'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
#                 'OpenAI-Beta' => 'assistants=v1'},
#       )
#     response = request.get
#     data = JSON.parse(response.body)
#     result = data['data'][0]["content"][0]["text"]["value"]

# puts result
# puts " "
# post = Post.last
# # post.description = result
# # post.save!
# # p post
# # puts " "
# # puts "Voici la description complète de mon post -> " + post.description
# # img_prompt = post.description[/(?<={).+?(?=})/]
# # img = Dalle3Image.new(prompt: img_prompt)
# # img.post = post
# # request = Faraday.new(
# #               url: "https://api.openai.com/v1/images/generations",
# #               headers: {'Content-Type' => 'application/json',
# #                         'Authorization' => "Bearer #{ENV['GPT_ANAIS']}"})
# # response = request.post do |r|
# #             r.body = {'model'=> 'dall-e-3',
# #                       'prompt' => img_prompt,
# #                       'size' => "1024x1024",
# #                       'quality' => 'hd',
# #                       'style' => "natural"}.to_json
# #           end
# # data = JSON.parse(response.body)
# # img.link = data['data'][0]['url']
# # img.save!
# # p img
# img = Dalle3Image.last
# puts img.link
# puts img.prompt
# request = Faraday.new(
#               url: "https://api.openai.com/v1/threads/thread_nDueinYDA8gVf0dAca1SuH16/runs/run_Qn1XKPQt6HYT5vdmuTqjmPIc",
#               headers: {'Content-Type' => 'application/json',
#                         'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
#                         'OpenAI-Beta' => 'assistants=v1'})
# response = request.get
# data = JSON.parse(response.body)
# puts data['status']

# Post.all.each do |post|
#   unless post.photos.empty?
#     post.photos.each do |photo|
#       post.photos_selected << photo.id
#       p post.photos_selected
#     end
#   end
# end
