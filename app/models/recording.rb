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
end
