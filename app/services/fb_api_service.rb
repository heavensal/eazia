class FbApiService
  def initialize(user)
    @user = user
  end

  # update le instagram_account du user
  def instagram_account(access_token)
    response = Faraday.new.get("https://graph.facebook.com/v19.0/me/accounts?fields=instagram_business_account&access_token=#{access_token}")
    data = JSON.parse(response.body)
    instagram_business = data["data"].first["instagram_business_account"]["id"]
    return instagram_business
  end

  def instagram_profile(instagram_account)
    response = Faraday.new.get("https://graph.facebook.com/v19.0/#{instagram_account.instagram_business}?fields=profile_picture_url,username&access_token=#{instagram_account.access_token}")
    data = JSON.parse(response.body)
    profile_picture_url = data["profile_picture_url"]
    username = data["username"]
    instagram_account.update!(photo_url: profile_picture_url, username: username)
  end

  # récupération le insta_id de l'user
  def ig_account(user)
    request = faraday_fb
    response = request.get("https://graph.facebook.com/v19.0/me/accounts?fields=id&access_token=#{user.token}")
    data = JSON.parse(response.body)
    p data
    page_id = data['data'].first['id']
    puts "page_id = " + page_id

    request_ig = faraday_fb
    response_ig = request_ig.get("https://graph.facebook.com/v19.0/#{page_id}/?fields=instagram_business_account&access_token=#{user.token}")
    data = JSON.parse(response_ig.body)
    puts data
    ig_id = data["instagram_business_account"]["id"]
    puts "ig_id = " + ig_id
    user.update!(ig_page: ig_id)
  end

  # créer un container pour le futur post insta
  def new_container(post)
    caption = URI.encode_www_form_component(post.gpt_creation.description)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.ig_page}/media?image_url=https://res.cloudinary.com/dhsr2pymr/image/upload/v1/production/#{post.photos.first.key}&caption=#{caption}&access_token=#{post.user.token}")
    data = JSON.parse(response.body)
    return data['id']
  end

  # publier le post qui a ete créé
  def publish(post, container)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.ig_page}/media_publish?creation_id=#{container}&access_token=#{post.user.token}")
  end



  private

  def faraday_fb
    Faraday.new
  end
end
