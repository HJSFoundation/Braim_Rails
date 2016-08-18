# == Schema Information
#
# Table name: recordings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  song_id    :integer
#  date       :datetime
#  duration   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Recording < ActiveRecord::Base
  belongs_to :song
  belongs_to :user
  has_many :entries
  
  validates :song_id, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :duration, presence: true
  
  scope :all_except, ->(user){where.not(user_id: user.id)}

  def self.search_by(song_query,user_query)
     Recording.where(user: user_query, song: song_query).where("duration >= ?", 29).last
     #r = Recording.select("recordings.*").joins(:entries).group("recordings.id").having("count(entries.id) > ?", 29).where(user: user_query, song: song_query).last
     #byebug
     #puts "sd"
     #r
  end
end
