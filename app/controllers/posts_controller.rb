class PostsController < ApplicationController
  def index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(new_post_params)
    @post.update!(user: current_user)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def new_post_params
    params.require(:post).permit(:prompt)
  end

  def gpt_prompt(post)
    Faraday.new(
      url: "https://api.openai.com/v1/threads/#{post.user.thread}/messages",
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                'OpenAI-Beta' => 'assistants=v1'}
      )
  end

  def run_thread(post)
    Faraday.new(
      url: "https://api.openai.com/v1/threads/#{post.user.thread}/messages",
      headers: {'Content-Type' => 'application/json',
                'Authorization' => "Bearer #{ENV['GPT_ANAIS']}",
                'OpenAI-Beta' => 'assistants=v1'},
      body: {'assistant_id'=> ENV['GPT_ASSISTANT']}
      )
  end

  def gpt_description

  end

end
