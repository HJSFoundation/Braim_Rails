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

FactoryGirl.define do
  factory :entry do
    event_id '4VqPOruhp5EdPBeR92t6lQ'
    user_id 1
    song_id 1
    recording_id 1
    interest 0.2
    engagement 0.3
    focus 0.4
    relaxation 0.2
    instantaneousExcitement 0.3
    longTermExcitement 0.3
    stress 0.2
    timestamp 1000
    date Time.now
  end
end