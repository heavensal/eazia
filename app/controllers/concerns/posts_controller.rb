class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    @post.user = current_user
    @post.save!
    gpt_prompt(@post) # POST message vers le thread
    run_thread(@post) # POST Run du thread pour attendre la réponse
    gpt_answer(@post) # GET dernier message du thread pour obtenir la réponse
    gpt_description(@post) # Creation de la description du post
    @post.save!
    gpt_dalle(@post) # Creation d'une image Dall-E
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt)
  end

  def gpt_prompt(post)
    # ici j'envoie un message a la conversation de l'user
    request = Faraday.new(
              url: "https://api.openai.com/v1/threads/#{post.user.thread}/messages",
              headers: {'Content-Type' => 'application/json',
                        'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                        'OpenAI-Beta' => 'assistants=v1'}
              )
    request.post do |m|
      m.body = {
        "role": "user",
        "content": post.prompt
    }.to_json
    end
  end

  def run_thread(post)
    # ici je lance le Run du message
    request = Faraday.new(
              url: "https://api.openai.com/v1/threads/#{post.user.thread}/runs",
              headers: {'Content-Type' => 'application/json',
                        'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                        'OpenAI-Beta' => 'assistants=v1'},
              )
    request.post do |r|
      r.body = {'assistant_id'=> ENV['GPT_ASSISTANT']}.to_json
    end
    sleep(45)
  end

  def gpt_answer(post)
    # ICI JE RECUPERE LE TEXTE DU DERNIER MESSAGE DONC DE CHATGPT
    request = Faraday.new(
      url: "https://api.openai.com/v1/threads/#{post.user.thread}/messages",
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                'OpenAI-Beta' => 'assistants=v1'},
      )
    response = request.get
    data = JSON.parse(response.body)
    result = data['data'][0]["content"][0]["text"]["value"]
    post.description = result
    post.save!
  end

  def gpt_description(post)
    # ici je capture ce qu'il y a entre [] pour le donner à post.description
    gpt_creation = GptCreation.new(description: post.description[/_%(.+?)%_/, 1])
    gpt_creation.post = post
    gpt_creation.save!
  end

  def gpt_dalle(post)
    # ici je capture ce qu'il y a entre {} pour le donner à dalle
    img_prompt = post.description[/(?<={).+?(?=})/]
    img = Dalle3Image.new(prompt: img_prompt)
    img.post = post
    request = Faraday.new(
              url: "https://api.openai.com/v1/images/generations",
              headers: {'Content-Type' => 'application/json',
                        'Authorization' => "Bearer #{ENV['GPT_ANAIS']}"})
    response = request.post do |r|
                r.body = {'model'=> 'dall-e-3',
                          'prompt' => img_prompt,
                          'size' => "1024x1024",
                          'quality' => 'hd',
                          'style' => "natural"}.to_json
              end
    data = JSON.parse(response.body)
    img.link = data['data'][0]['url']
    img.save!
  end

end
