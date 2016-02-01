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
  #validates :event_id , presence: true
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
  def save_prediction_info
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
    request = PioClient.create_event(
      'emotion_rate',
      'user',
      self.user_id, {
        'targetEntityType' => 'item',
        'targetEntityId' => self.song_id,
        'properties' => entry_info
      }
    )
    self.event_id = JSON.parse(request.body)['eventId']
  end

  def self.save_prediction_batch(recording_id,total_entries) 
    exporter = PredictionIO::FileExporter.new("import_entries/#{recording_id}")
    total_entries.each do |entry|
      prediction_entry = {}
      prediction_entry['targetEntityType'] = "item"
      prediction_entry['targetEntityId'] = entry.song_id
      prediction_entry['properties'] = {}
      prediction_entry['properties']['interest'] = entry.interest
      prediction_entry['properties']['engagement'] = entry.engagement
      prediction_entry['properties']['focus'] = entry.focus
      prediction_entry['properties']['relaxation'] = entry.relaxation
      prediction_entry['properties']['instantaneousExcitement'] = entry.instantaneousExcitement
      prediction_entry['properties']['longTermExcitement'] = entry.longTermExcitement
      prediction_entry['properties']['stress'] = entry.stress
      prediction_entry['properties']['timestamp'] = entry.timestamp
      prediction_entry['properties']['date'] = entry.date.to_i
      exporter.create_event('emotion_rate','user',entry.user_id,prediction_entry)
    end
    exporter.close
  end

  def self.masive_record(total_entries)
    ActiveRecord::Base.transaction do
      total_entries.each do |entry|
        entry.save
      end
    end
  end

end
