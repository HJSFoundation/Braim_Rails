require 'elasticsearch/persistence/model'
class Rating
  include Elasticsearch::Persistence::Model

  index_name "braim"
  attribute :user_id,  Integer, mapping: { type: 'integer' }
  attribute :song_id,  String,  mapping: { analyzer: 'snowball' }
  attribute :value, Integer, mapping: { analyzer: 3 }
  
  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :value, presence: true

  # Execute code after saving the model.
  #
  #after_save { puts "Successfully saved: #{self}" }
end
