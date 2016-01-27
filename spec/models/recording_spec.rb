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

require 'rails_helper'

RSpec.describe Recording, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:recording)).to be_valid
  end
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:song_id)}
  it {should validate_presence_of(:date)}
  it {should validate_presence_of(:duration)}
end
