class GptCreationsController < ApplicationController

  def edit
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
    @description = @gpt_creation.description
  end

  def update
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
    if @gpt_creation.update(description_params)
      redirect_to post_path(@post), notice: 'Description mise à jour avec succès.'
    else
      redirect_to post_path(@post), status: :unprocessable_entity, notice: 'Erreur lors de la mise à jour de la description. Merci de réessayer.'
    end
  end

  def recreate
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
    ai_api_service = AiApiService.new(@post.user)
    ai_api_service.work_2(@post)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@gpt_creation, partial: "gpt_creations/recreate", locals: { gpt_creation: @gpt_creation })
      end
      format.html { redirect_to post_path(@post) } # Fallback pour les navigateurs sans prise en charge de Turbo
    end
  end

  private

  def description_params
    params.require(:gpt_creation).permit(:description)
  end
end
