class FbApiService
  FB_URL = "https://graph.facebook.com/v19.0"
  CLOUDINARY_URL = "https://res.cloudinary.com/dhsr2pymr/image/upload/v1/production"
  def initialize(user)
    @user = user
  end

  # update le token du user
  def instagram_account(access_token)
    response = Faraday.new.get("#{FB_URL}/me/accounts?fields=instagram_business_account&access_token=#{access_token}")
    data = JSON.parse(response.body)
    instagram_business = data["data"].first["instagram_business_account"]["id"]
    return instagram_business
  end

  # update le instagram_account du user
  def instagram_profile(instagram_account)
    response = Faraday.new.get("#{FB_URL}/#{instagram_account.instagram_business}?fields=profile_picture_url,username&access_token=#{instagram_account.access_token}")
    data = JSON.parse(response.body)
    profile_picture_url = data["profile_picture_url"]
    username = data["username"]
    instagram_account.update!(photo_url: profile_picture_url, username: username)
  end

  def publish(post)
    container_id = ""
    caption = URI.encode_www_form_component(post.gpt_creation.description)
    containers = []
    photos_selected = post.photos_selected.map do |id|
      post.photos.where(id: post.photos_selected).detect { |photo| photo.id == id.to_i }
    end.compact
    # S'il y a 1 photo ?
    if photos_selected.count == 1
      container_id = one_photo(post, caption, photos_selected.first)
    else
      container_id = carrousel(post, caption, containers, photos_selected)
      # je publie le carrousel ou le container
      publish_container(post, container_id)
    end
  end


  private

  def one_photo(post, caption, photo)
    response = Faraday.new.post("#{FB_URL}/#{post.user.instagram_account.instagram_business}/media?image_url=#{CLOUDINARY_URL}/#{photo.key}&caption=#{caption}&access_token=#{post.user.instagram_account.access_token}")
    data = JSON.parse(response.body)
    container_id = data['id']
    return container_id
  end

  def carrousel(post, caption, containers, photos_selected)
    photos_selected.each do |photo|
      # pour chaque photo selected, je crée un container pour le carroussel insta
      response = Faraday.new.post("#{FB_URL}/#{post.user.instagram_account.instagram_business}/media?image_url=#{CLOUDINARY_URL}/#{photo.key}&is_carousel_item=true&access_token=#{post.user.instagram_account.access_token}")
      data = JSON.parse(response.body)
      container_id = data['id']
      # je stocke les containers dans un tableau
      containers << container_id
    end
    # je crée un container pour le carroussel
    # j'ajoute la description de post "caption"
    # je crée un carroussel avec les containers
    response = Faraday.new.post("#{FB_URL}/#{post.user.instagram_account.instagram_business}/media?caption=#{caption}&media_type=CAROUSEL&children=#{containers.join(',')}&access_token=#{post.user.instagram_account.access_token}")
    data = JSON.parse(response.body)
    # ca c'est le id du container du carroussel
    return carrousel = data['id']
  end

  def publish_container(post, container_id)
    Faraday.new.post("#{FB_URL}/#{post.user.instagram_account.instagram_business}/media_publish?creation_id=#{container_id}&access_token=#{post.user.instagram_account.access_token}")
    # id de la publication
    return JSON.parse(response.body)
  end
end
