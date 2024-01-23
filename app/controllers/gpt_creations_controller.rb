class GptCreationsController < ApplicationController
  def rewrite
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
    if @gpt_creation.update(description_params)
      redirect_to post_path(@post)
    end
  end

  def recreate
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work_2(@post)
    redirect_to post_path(@post)
  end

  private

  def description_params
    params.require(:gpt_creation).permit(:description)
  end
end
