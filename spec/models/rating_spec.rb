# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  song_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Rating, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:rating)).to be_valid
  end
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:song_id)}
  it {should validate_presence_of(:value)}
  context "instance methods" do
    context "save_prediction_info" do
      it "set rating on prediction io" do
        rating = FactoryGirl.create(:rating)
        expect(rating.save_prediction_info).not_to be_falsey
      end
    end
  end
end
