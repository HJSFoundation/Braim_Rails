module ApplicationHelper

  def controller_assets
    controller = params[:controller]
    if Rails.application.config.controller_with_assets.include? controller
      javascript_include_tag(controller) + stylesheet_link_tag(controller)
    elsif devise_controller?
      javascript_include_tag('devise') + stylesheet_link_tag('devise')
    else
      javascript_include_tag('users') + stylesheet_link_tag('users')
    end
  end

  def gravatar_url(user)

    default_url = "http://santetotal.com/wp-content/uploads/2014/05/default-user-450x450.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=#{CGI.escape(default_url)}"
  
  end
end
