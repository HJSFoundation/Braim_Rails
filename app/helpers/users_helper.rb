# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  last_name              :string
#  country                :string
#

module UsersHelper
  def spotify_image_tag(item)
    if item.images.any? 
      image_tag item.images.first["url"] , class: "lib-img-show artist-image" 
    else
      image_tag "default-image.png", class: "lib-img-show artist-image" 
    end
  end
end
