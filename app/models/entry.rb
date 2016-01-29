# == Schema Information
#
# Table name: entries
#
#  id                      :integer          not null, primary key
#  event_id                :string
#  user_id                 :integer
#  song_id                 :integer
#  recording_id            :integer
#  interest                :float
#  engagement              :float
#  focus                   :float
#  relaxation              :float
#  instantaneousExcitement :float
#  longTermExcitement      :float
#  stress                  :float
#  timestamp               :integer
#  date                    :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Entry < ActiveRecord::Base
  belongs_to :recording
  validates :event_id , presence: true
  validates :user_id , presence: true
  validates :song_id , presence: true
  validates :recording_id , presence: true
  validates :interest , presence: true
  validates :engagement , presence: true
  validates :focus , presence: true
  validates :relaxation , presence: true
  validates :instantaneousExcitement , presence: true
  validates :longTermExcitement , presence: true
  validates :stress , presence: true
  validates :timestamp , presence: true
  validates :date , presence: true
  def save_and_index(client)
    entry_info = {
      recording_id: self.recording_id,
      interest: self.interest,
      engagement: self.engagement,
      focus: self.focus,
      relaxation: self.relaxation,
      instantaneousExcitement: self.instantaneousExcitement,
      longTermExcitement: self.longTermExcitement,
      stress: self.stress,
      timestamp: self.timestamp,
      date: self.date
    }
    request = client.create_event(
      'emotion_rate',
      'user',
      self.user_id, {
        'targetEntityType' => 'item',
        'targetEntityId' => self.song_id,
        'properties' => entry_info
      }
    )
    self.event_id = JSON.parse(request.body)['eventId']
    save if self.event_id
  end
end
