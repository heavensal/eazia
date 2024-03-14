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

  # créer un container pour le futur post insta
  def new_container(post)
    caption = URI.encode_www_form_component(post.gpt_creation.description)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.ig_page}/media?image_url=https://res.cloudinary.com/dhsr2pymr/image/upload/v1/production/#{post.photos.first.key}&caption=#{caption}&access_token=#{post.user.token}")
    data = JSON.parse(response.body)
    return data['id']
  end

  def carrousel(post)
    caption = URI.encode_www_form_component(post.gpt_creation.description)
    # S'il y a 1 photo ?

    # si il y a plusieurs photos, je crée un carroussel
    containers = []
    # je récupère les photos selected
    photos_selected = post.photos_selected.map do |id|
      post.photos.where(id: post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact
    photos_selected.each do |photo|
      # pour chaque photo selected, je crée un container pour le carroussel insta
      response = Faraday.new.post("https://graph.facebook.com/v19.0/#{post.user.instagram_account.instagram_business}/media?image_url=https://res.cloudinary.com/dhsr2pymr/image/upload/v1/production/#{photo.key}&is_carousel_item=true&access_token=#{post.user.instagram_account.access_token}")
      data = JSON.parse(response.body)
      container = data['id']
      # je stocke les containers dans un tableau
      containers << container
    end
    # je crée un container pour le carroussel
    # j'ajoute la description de post "caption"
    # je crée un carroussel avec les containers
    response = Faraday.new.post("https://graph.facebook.com/v19.0/#{post.user.instagram_account.instagram_business}/media?caption=#{caption}&media_type=CAROUSEL&children=#{containers.join('%')}&access_token=#{post.user.instagram_account.access_token}")
    data = JSON.parse(response.body)
    # ca c'est le id du container du carroussel
    carrousel = data['id']
    # je publie le carrousel
    Faraday.new.post("https://graph.facebook.com/v19.0/#{post.user.instagram_account.instagram_business}/media_publish?creation_id=#{carrousel}&access_token=#{post.user.instagram_account.access_token}")
  end

  # publier le post qui a ete créé
  def publish(post, container)
    request = faraday_fb
    response = request.post("https://graph.facebook.com/v19.0/#{post.user.instagram_account.instagram_business}/media_publish?creation_id=#{container}&access_token=#{post.user.token}")
  end

  private

  def faraday_fb
    Faraday.new
  end
end
