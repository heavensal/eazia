class AiApiService
  def initialize(user)
    @user = user
    @api_key = ENV['GPT_ANAIS']
  end

  # Réaliser Mission 1: Générer une description insta et des photos
  def work_1(post)
    prompt(post)
    status_run(post, run(post))
    answer(post)
    post.save!
  end

  # Réaliser la mission 2: Récréer la description chatgpt
  def work_2(post)
    recreate(post)
    status_run(post, run(post))
    answer_2(post)
    post.gpt_creation.save!
  end

  # Logique pour envoyer un prompt
  def prompt(post)
    request = faraday_ai
    request.post("https://api.openai.com/v1/threads/#{post.user.thread}/messages") do |m|
      m.body = {
        "role": "user",
        "content": "Mission 1 " + post.prompt
    }.to_json
    end
  end

  # Logique pour recréer la description
  def recreate(post)
    request = faraday_ai
    request.post("https://api.openai.com/v1/threads/#{post.user.thread}/messages") do |m|
      m.body = {
        "role": "user",
        "content": "Mission 2"
    }.to_json
    end
  end

  # Logique pour exécuter le thread, renvoyer le id du run pour check son status
  def run(post)
    request = faraday_ai
    response = request.post("https://api.openai.com/v1/threads/#{post.user.thread}/runs") do |r|
      r.body = {'assistant_id'=> ENV['GPT_ASSISTANT']}.to_json
    end
    data = JSON.parse(response.body)
    return data['id']
  end

  # Boucle pour vérifier si le run est fini
  def status_run(post, run)
    status = ''
    request = faraday_ai
    begin
      response = request.get("https://api.openai.com/v1/threads/#{post.user.thread}/runs/#{run}")
      data = JSON.parse(response.body)
      status = data['status']
      sleep(3)
    end while status != 'completed'
  end

  # Logique pour obtenir la réponse de la mission 1
  def answer(post)
    request = faraday_ai
    response = request.get("https://api.openai.com/v1/threads/#{post.user.thread}/messages")
    data = JSON.parse(response.body)
    result = data['data'].first["content"].first["text"]["value"]
    post.description = result
  end

  # Logique pour obtenir la description récréée de la mission 2
  def answer_2(post)
    request = faraday_ai
    response = request.get("https://api.openai.com/v1/threads/#{post.user.thread}/messages")
    data = JSON.parse(response.body)
    result = data['data'].first["content"].first["text"]["value"]
    post.gpt_creation.description = result
  end


  def image(post)
    prompt = post.description[/(?<={).+?(?=})/]
    img = Dalle3Image.new(prompt: prompt)
    img.post = post
    request = faraday_ai
    response = request.post("https://api.openai.com/v1/images/generations", headers: {'OpenAI-Beta' => nil}) do |r|
      r.body = {'model'=> 'dall-e-3',
                          'prompt' => prompt,
                          'size' => "1024x1024",
                          'quality' => 'hd',
                          'style' => "vivid"}.to_json
    end
    data = JSON.parse(response.body)
    img.link = data['data'].first['url']
    img.save!
    return img.post.photos.last
  end

  private

  def faraday_ai
    Faraday.new(
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{@api_key}",
                'OpenAI-Beta' => 'assistants=v1'})
  end
end
