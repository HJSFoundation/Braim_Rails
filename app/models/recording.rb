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
  scope :all_min, ->{where("duration > ?", 29)}

  def increments_counter(state)
    res = 0
    bigger_than_three = false
    bigger_than_six = false
    if entries.count >= 30
      res = 1
      first_fraction = entries.take 30
      fractions = first_fraction.each_slice(10)
      fractions.each do |fraction| 
        bigger_than_three = true if (fraction.last[state] - fraction.first[state]) >= 0.3
        bigger_than_six = true if (fraction.last[state] - fraction.first[state]) >= 0.6

        #byebug
      end
      res += 1 if bigger_than_three
      res += 1 if bigger_than_six
      res += 1 if (first_fraction.last[state] - first_fraction.first[state]) >= 0.3
      res += 1 if (first_fraction.last[state] - first_fraction.first[state]) >= 0.6
    end
    return res
  end

  def self.search_by(song_query,user_query)
     Recording.where(user: user_query, song: song_query).where("duration >= ?", 29).last
     #r = Recording.select("recordings.*").joins(:entries).group("recordings.id").having("count(entries.id) > ?", 29).where(user: user_query, song: song_query).last
     #byebug
     #puts "sd"
     #r
  end
end
