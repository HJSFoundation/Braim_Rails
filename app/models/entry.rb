require 'elasticsearch/persistence/model'
class Entry
  include Elasticsearch::Persistence::Model

  index_name "braim"
  attribute :user_id,  Integer, mapping: { type: 'integer' }
  attribute :song_id,  String,  mapping: { analyzer: 'snowball' }
  attribute :recording_id ,String, mapping: { analyzer: '4VqPOruhp5EdPBeR92t6lQ'}
  attribute :interest,  Float,  mapping: { analyzer: 0.553663 }
  attribute :engagement,  Float,  mapping: { analyzer: 0.553663 }
  attribute :focus,  Float,  mapping: { analyzer: 0.553663 }
  attribute :relaxation,  Float,  mapping: { analyzer: 0.553663 }
  attribute :instantaneousExcitement,  Float,  mapping: { analyzer: 0.553663 }
  attribute :longTermExcitement,  Float,  mapping: { analyzer: 0.553663 }
  attribute :stress,  Float,  mapping: { analyzer: 0.553663 }
  attribute :timestamp,  Integer,  mapping: { type: 'integer'  }
  attribute :date, Date
  
  # Validate the presence of the `title` attribute
  #
  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :recording_id, presence: true

  # Execute code after saving the model.
  #
  #after_save { puts "Successfully saved: #{self}" }
end
