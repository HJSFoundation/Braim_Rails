require 'elasticsearch/persistence/model'
class Recording
  include Elasticsearch::Persistence::Model

  index_name "braim"
  attribute :user_id,  Integer, mapping: { type: 'integer' }
  attribute :song_id,  String,  mapping: { analyzer: 'snowball' }
  attribute :date, Date
  # Validate the presence of the `title` attribute
  #
  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :date, presence: true
  # Execute code after saving the model.
  #
  after_save { puts "Successfully saved: #{self}" }
end