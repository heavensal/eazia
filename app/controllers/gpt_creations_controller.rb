class GptCreationsController < ApplicationController
  def rewrite
    @post = Post.find(params[:post_id])
  end

  def recreate
    @post = Post.find(params[:post_id])
    @gpt_description = @post.gpt_creation
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work_2(@post)
    redirect_to post_path(@post)
  end
end
