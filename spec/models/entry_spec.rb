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

require 'rails_helper'

RSpec.describe Entry, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:entry)).to be_valid
  end
  it {should validate_presence_of(:event_id)}
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:song_id)}
  it {should validate_presence_of(:recording_id)}
  it {should validate_presence_of(:interest)}
  it {should validate_presence_of(:engagement)}
  it {should validate_presence_of(:focus)}
  it {should validate_presence_of(:relaxation)}
  it {should validate_presence_of(:instantaneousExcitement)}
  it {should validate_presence_of(:longTermExcitement)}
  it {should validate_presence_of(:stress)}
  it {should validate_presence_of(:timestamp)}
  it {should validate_presence_of(:date)}
  context "instance methods" do
    context "save_prediction_info" do
      it "set entry on prediction io" do
        entry = FactoryGirl.create(:entry)
        client = PioClient.new_client
        expect(entry.save_prediction_info(client)).not_to be_falsey
      end
    end
  end
end