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
    gpt_prompt(@post)
    run_thread(@post)
    gpt_description(@post)
    @post.save!

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
    sleep(30)
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
    return result
  end

  def gpt_description(post)
    # ici je capture ce qu'il y a entre [] pour le donner à post.description
    post.description = gpt_answer(post)[/_%(.+?)%_/]
    post.save!
  end

  def gpt_dalle(result)
    # ici je capture ce qu'il y a entre {} pour le donner à dalle
    dalle_prompt = result[/(?<={).+?(?=})/]
    return dalle_prompt
  end

end
