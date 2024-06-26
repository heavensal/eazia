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
#       unless photo.id.in?(post.photos_selected)
#         post.photos_selected << photo.id
#         p post.photos_selected
#       end
#     end
#   end
#   post.save!
# end

# Product.create(name: "Starter Pack", price: 19, description: "30 jetons crédités dans votre porte-monnaie. Le pack idéal pour débuter et découvrir l'ensemble des fonctionnalités d'Eazia.", mode: "payment", stripe_price_id: "price_1OvgwEGGbOzXfEYBDiBtOljC")

# Product.create(name: "Ultimate Pack", price: 59, description: "100 jetons crédités dans votre porte-monnaie. Le pack ultime pour les utilisateurs réguliers d'Eazia. La puissance de l'IA n'a pas de secret pour vous.", mode: "payment", stripe_price_id: "price_1OvgwiGGbOzXfEYBpp6pZnCM")

# Product.create(name: "1 mois d'abonnement Premium", price: 59, description: "100 jetons crédités mensuellement dans votre porte-monnaie. Abonnez-vous aux services d'Eazia et exploitez le potentiel de l'IA à son maximum.", mode: "subscription", stripe_price_id: "price_1Ovh26GGbOzXfEYBtvoxZqXs")

# Product.create(name: "3 mois d'abonnement Premium", price: 159, description: "100 jetons crédités mensuellement dans votre porte-monnaie. Souscrivez à l'abonnement Premium d'Eazia pendant 3 mois et bénéficiez d'une réduction de 10% par mois.", mode: "subscription", stripe_price_id: "price_1Ovh6CGGbOzXfEYB6x8t5x8T")

# Product.create(name: "1 an d'abonnement Premium", price: 495, description: "100 jetons crédités mensuellement dans votre porte-monnaie. Souscrivez 1 année à Eazia et profitez d'avantages exclusifs à Eazia.", mode: "payment", stripe_price_id: "price_1Ovh7RGGbOzXfEYBG8d8mWzI")


# Product.create(name: "Ultimate Pack TEST",
#                price: 59,
#                amount: 100,
#                description: "TEST 100 jetons crédités Le pack ultime pour les utilisateurs réguliers d'Eazia. La puissance de l'IA n'a pas de secret pour vous.",
#                mode: "payment",
#                stripe_price_id: "price_1OvzMLGGbOzXfEYBkzZDqlXO")

# Product.create(name: "Premium x3 TEST",
#                price: 159,
#                description: "TEST 100 jetons crédités mensuellement dans votre porte-monnaie. L'IA n'a pas de secret pour vous. Bénéficiez d'une réduction de 10% par mois en achetant 3 mois.",
#                mode: "subscription",
#                stripe_price_id: "price_1OvzQUGGbOzXfEYBgVyFme6b",
#                subscribe_type: "tous les 3 mois")


Subscription.destroy_all
Product.destroy_all

Subscription.create!(name: "TEST Offre spéciale Eazia 1.0",
description: "Bénéficiez de l'offre spéciale pour la sortie de la version 1.0 d'Eazia. 6 mois d'abonnement Premium au prix unique de 19.00 €. Aucun paiement mensuel supplémentaire n'est requis ! 100 jetons crédités mensuellement dans votre porte-monnaie.",
price: 19,
mode: "payment",
duration: "durant 6 mois",
stripe_price_id: "price_1P1puLGGbOzXfEYB7m2nbo8A")

Subscription.create!(name: "TEST 1 Mois d'abonnement Premium",
description: "Abonnez-vous aux services d'Eazia et exploitez le potentiel de l'IA à son maximum. 100 jetons crédités mensuellement dans votre porte-monnaie.",
price: 59,
mode: "subscription",
duration: "mois",
stripe_price_id: "price_1P1pxNGGbOzXfEYB54lLDqIN")

Subscription.create!(name: "TEST 3 Mois d'abonnement Premium",
description: "L'IA n'a pas de secret pour vous. Souscrivez à l'abonnement Premium d'Eazia pendant 3 mois et bénéficiez d'une réduction de 10% par mois. 100 jetons crédités mensuellement dans votre porte-monnaie.",
price: 159,
mode: "subscription",
duration: "Tous les 3 mois",
stripe_price_id: "price_1OvzQUGGbOzXfEYBgVyFme6b")

Subscription.create!(name: "TEST 1 An d'abonnement Premium",
description: "Souscrivez 1 année à Eazia et profitez d'avantages exclusifs à Eazia. 100 jetons crédités mensuellement dans votre porte-monnaie.",
price: 495,
mode: "subscription",
duration: "an",
stripe_price_id: "price_1P1q2vGGbOzXfEYBKpe2wG8k")


Product.create!(name: "TEST Starter Pack - 30 jetons",
price: 19,
description: "30 jetons crédités dans votre porte-monnaie. Le pack idéal pour débuter et découvrir l'ensemble des fonctionnalités d'Eazia.",
mode: "payment",
amount: 30,
stripe_price_id: "price_1OvirYGGbOzXfEYBcLRivk1i")

Product.create!(name: "TEST Ultimate Pack - 100 jetons",
price: 59,
description: "100 jetons crédités dans votre porte-monnaie. Le pack ultime pour les utilisateurs réguliers d'Eazia. La puissance de l'IA n'a pas de secret pour vous.",
mode: "payment",
amount: 100,
stripe_price_id: "price_1OvzMLGGbOzXfEYBkzZDqlXO")

Subscription.create!(name: "Offre spéciale Eazia 1.0",
description: "Bénéficiez de l'offre spéciale pour la sortie de la version 1.0 d'Eazia. 6 mois d'abonnement Premium au prix unique de 19.00 €. Aucun paiement mensuel supplémentaire n'est requis ! 100 jetons crédités mensuellement dans votre porte-monnaie.",
price: 19,
mode: "payment",
duration: "Durant 6 mois",
stripe_price_id: "price_1P1ZSkGGbOzXfEYBaSg77JyE")

User.create(email: 'test@example.com', password: '123456', confirmed_at: Time.now, status: "admin")
User.create(email: 'emma@example.com', password: '123456', confirmed_at: Time.now, status: "admin")
