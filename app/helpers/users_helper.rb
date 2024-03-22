module UsersHelper
  def render_navbar
    render 'layouts/navbar' if user_signed_in?
  end
end
