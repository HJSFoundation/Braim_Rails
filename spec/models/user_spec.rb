require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:country)}

  context "save_prediction_info" do
    it "set index on prediction io" do
      user = FactoryGirl.create(:user)
      expect(user.save_prediction_info).not_to be_falsey
    end
  end

end
