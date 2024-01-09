class AiApiService
  def initialize(user)
    @user = user
    @api_key = ENV['GPT_ANAIS']
  end

  def work(post)
    prompt(post)
    run(post)
    answer(post)
    post.save!
  end

  def prompt(post)
    # Logique pour envoyer un prompt
    request = faraday_ai
    request.post("https://api.openai.com/v1/threads/#{post.user.thread}/messages") do |m|
      m.body = {
        "role": "user",
        "content": post.prompt
    }.to_json
    end
  end

  def run(post)
    # Logique pour exécuter le thread
    request = faraday_ai
    request.post("https://api.openai.com/v1/threads/#{post.user.thread}/runs") do |r|
      r.body = {'assistant_id'=> ENV['GPT_ASSISTANT']}.to_json
    end
    sleep(25)
  end

  def answer(post)
    # Logique pour obtenir la réponse
    request = faraday_ai
    response = request.get("https://api.openai.com/v1/threads/#{post.user.thread}/messages")
    data = JSON.parse(response.body)
    result = data['data'].first["content"].first["text"]["value"]
    post.description = result
  end

  def image(post)
    img_prompt = post.description[/(?<={).+?(?=})/]
    img = Dalle3Image.new(prompt: img_prompt)
    img.post = post
    request = faraday_ai
    response = request.post("https://api.openai.com/v1/images/generations", headers: {'OpenAI-Beta' => nil}) do |r|
      r.body = {'model'=> 'dall-e-3',
                          'prompt' => img_prompt,
                          'size' => "1024x1024",
                          'quality' => 'hd',
                          'style' => "natural"}.to_json
    end
    data = JSON.parse(response.body)
    img.link = data['data'].first['url']
    img.save!
  end

  private

  def faraday_ai
    Faraday.new(
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{@api_key}",
                'OpenAI-Beta' => 'assistants=v1'})
  end
end
