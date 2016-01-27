require 'elasticsearch/persistence/model'
class RecordingElastic
  include Elasticsearch::Model
  include Elasticsearch::Persistence::Model

  index_name "braim"
  attribute :user_id,  Integer, mapping: { type: 'integer' }
  attribute :duration,  Integer, mapping: { type: 'integer' }
  attribute :song_id,  String,  mapping: { analyzer: 'snowball' }
  attribute :date, Date
  # Validate the presence of the `title` attribute
  #
  validates :user_id, presence: true
  validates :song_id, presence: true
  validates :date, presence: true
  validates :duration, presence: true
  # Execute code after saving the model.
  #
  #after_save { puts "Successfully saved: #{self}" }

  def self.all_query(page = 1, per_page = 100,user_id,song_id)
    #byebug
    page ||= 1
    search({
      query: {
        bool:{
          must: [
            { match: {user_id: user_id}},
            { match: {song_id: song_id}}
          ]
        }
       },
       sort: [{date: {order: "desc", mode: "avg"}}],
       size: per_page,
       from: (page.to_i - 1) * per_page
     })
  end
end