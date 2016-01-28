class Entry
  include ActiveModel::Model

  attr_accessor :user_id, :song_id , :recording_id , :interest ,:engagement , :focus , :relaxation,
   :instantaneousExcitement ,:longTermExcitement , :stress , :timestamp , :date


  # attribute :user_id,  Integer, mapping: { type: 'integer' }
  # attribute :song_id,  String,  mapping: { analyzer: 'snowball' }
  # attribute :recording_id ,String, mapping: { analyzer: '4VqPOruhp5EdPBeR92t6lQ'}
  # attribute :interest,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :engagement,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :focus,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :relaxation,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :instantaneousExcitement,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :longTermExcitement,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :stress,  Float,  mapping: { analyzer: 0.553663 }
  # attribute :timestamp,  Integer,  mapping: { type: 'integer'  }
  # attribute :date, Date
  
  # Validate the presence of the `title` attribute
  #
  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :recording_id, presence: true

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
    request = PioClient.new_client.create_event(
      'emotion_rate',
      'user',
      self.user_id, {
        'targetEntityType' => 'item',
        'targetEntityId' => self.song_id,
        'properties' => entry_info
      }
    )
  end

  # Execute code after saving the model.
  #
  #after_save { puts "Successfully saved: #{self}" }
end
