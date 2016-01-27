# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  song_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :song
  validates :user_id , presence: true
  validates :song_id , presence: true
  validates :value , presence: true
  def save_prediction_info
    song_info = self.attributes
    song_info.delete('id')
    request = PioClient.new_client.create_event(
      'rate',
      'user',
      self.user_id, {
        'targetEntityType' => 'item',
        'targetEntityId' => self.song_id,
        'properties' => { 'rating' => self.value }
      }
    )
    return JSON.parse(request.body)['eventId']
  end
end
