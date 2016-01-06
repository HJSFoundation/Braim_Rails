module UsersHelper
  def spotify_image_tag(item)
    if item.images.any? 
      image_tag item.images.first["url"] , class: "lib-img-show artist-image" 
    else
      image_tag "default-image.png", class: "lib-img-show artist-image" 
    end
  end
end
