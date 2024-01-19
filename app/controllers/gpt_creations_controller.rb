class GptCreationsController < ApplicationController
  def rewrite
    @post = Post.find(params[:post_id])
  end

  def recreate
    @post = Post.find(params[:post_id])
    @description = @post.gpt_creation.description
  end
end
