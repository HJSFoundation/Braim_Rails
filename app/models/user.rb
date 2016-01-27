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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  has_many :ratings
  has_many :songs, :through => :ratings

  accepts_nested_attributes_for :profile

  def full_name
    (self.name || "").capitalize
  end
  
  def country_name
    country = ISO3166::Country[self.country]
    country ? country.translations[I18n.locale.to_s].capitalize : ""
  end
  # def save_and_index
  #   if self.save
  #     user_info = {'email'=> self.email, 'name'=> self.name, 'last_name'=> self.last_name, 'country'=> self.country}
  #     profile_info = {}
  #     profile_info = {'birthday'=>self.profile.birthday,'gender'=>self.profile.gender} if self.profile
  #     request = PIO_CLIENT.create_event(
  #       '$set',
  #       'user',
  #       self.id,
  #       { 'properties' => user_info.merge(profile_info)}
  #     )
  #     return JSON.parse(request.body)['eventId']
  #   else
  #     return false
  #   end
  # end
  def save_prediction_info
   user_info = {'email'=> self.email, 'name'=> self.name, 'last_name'=> self.last_name, 'country'=> self.country}
    profile_info = {}
    profile_info = {'birthday'=>self.profile.birthday,'gender'=>self.profile.gender} if self.profile
    request = PioClient.new_client.create_event(
      '$set',
      'user',
      self.id,
      { 'properties' => user_info.merge(profile_info)}
    )
    return JSON.parse(request.body)['eventId']
  end
  validates :name , presence: true
  validates :last_name , presence: true
  validates :country , presence: true
end
