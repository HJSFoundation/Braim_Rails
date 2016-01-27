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

FactoryGirl.define do
  factory :recording do
    user_id 1
    song_id 1
    date Time.now
    duration 1
  end
end
