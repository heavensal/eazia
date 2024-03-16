class GptCreationsController < ApplicationController
  before_action :set_vars

  def edit
    @description = @gpt_creation.description
  end

  def update
    if @gpt_creation.update(description_params)
      turbo_render(@post, @gpt_creation)
    else
      redirect_to post_path(@post), status: :unprocessable_entity, notice: 'Erreur lors de la mise à jour de la description. Merci de réessayer.'
    end
  end

  def recreate
    @gpt_creation = @post.gpt_creation
    begin
      ai_api_service = AiApiService.new(@post.user)
      ai_api_service.work_2(@post)
      turbo_render(@post, @gpt_creation)
    rescue
      redirect_to post_path(@post), alert: "Suite à une erreur de l'IA, la description de votre brouillon n'a pas pu être recréée. Merci de réessayer ultérieurement."
    end
  end

  private

  def set_vars
    @post = Post.find(params[:post_id])
    @gpt_creation = @post.gpt_creation
  end

  def description_params
    params.require(:gpt_creation).permit(:description)
  end

  def turbo_render(post, gpt_creation)
    respond_to do |f|
      f.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(gpt_creation, partial: "gpt_creations/recreate", locals: { gpt_creation: gpt_creation }),
          turbo_stream.replace("insta-#{gpt_creation.id}" , partial: "gpt_creations/insta-description", locals: { gpt_creation: gpt_creation, description: gpt_creation.description })
        ]
      end
      f.html do
        redirect_to post_path(post)
      end
    end
  end

end
