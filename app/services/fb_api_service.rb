class FbApiService
  def initialize(user)
    @user = user
  end

  # récupération le insta_id de l'user
  def ig_account(user)
    request = faraday_fb
    response = request.get("https://graph.facebook.com/v19.0/me/accounts?fields=id&access_token=#{user.token}")
    data = JSON.parse(response.body)
    page_id = data['data'].first['id']

    request_ig = faraday_fb
    response_ig = request_ig.get("https://graph.facebook.com/v19.0/#{page_id}/?fields=instagram_business_account&access_token=#{user.token}")
    data = JSON.parse(response_ig.body)
    ig_id = data["instagram_business_account"]["id"]
    user.update!(ig_page: ig_id)
  end

  # créer un container pour le futur post insta
  def new_container(post)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.ig_id}/media?image_url=#{post.photos.first.key}&caption=#{post.gpt_creation.description}&access_token=#{post.user.token}")
    data = JSON.parse(response.body)
    return data['id']
  end

  # publier le post qui a ete créé
  def publish(post, container)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.ig_id}/media_publish?creation_id=#{container}&access_token=#{post.user.token}")
  end



  private

  def faraday_fb
    Faraday.new
  end
end
