class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    @post.user = current_user
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work(@post)
    GptCreation.create_description(@post) # Creation de la description du post
    gpt_dalle(@post) # Creation d'une image Dall-E
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @images = @post.dalle3_images
    # @images = @post.photos.key quand il y aura cloudinary
    @description = @post.gpt_creation.description
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt)
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
    img.link = data['data'].first['url']
    img.save!
  end

end
