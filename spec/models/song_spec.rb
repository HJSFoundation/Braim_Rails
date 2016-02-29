# == Schema Information
#
# Table name: songs
#
#  id                        :integer          not null, primary key
#  song_spotify_id           :string
#  song_spotify_url          :string
#  name                      :string
#  preview_url               :string
#  album_cover_url           :string
#  album_name                :string
#  duration                  :integer
#  artist_name               :string
#  artist_spotify_id         :string
#  echonest_song_type        :string           is an Array
#  echonest_key              :integer
#  echonest_energy           :float
#  echonest_liveness         :float
#  echonest_tempo            :float
#  echonest_speechiness      :float
#  echonest_acousticness     :float
#  echonest_instrumentalness :float
#  echonest_mode             :integer
#  echonest_time_signature   :integer
#  echonest_loudness         :float
#  echonest_valence          :float
#  echonest_danceability     :float
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  echonest_id               :string
#

require 'rails_helper'

RSpec.describe Song, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:song)).to be_valid
  end
  context "class methods" do
    context "find_or_register(song_spotify_id)" do
      describe "if song does not exists" do
        it "should get song info from spotify and echonest APIS and register it to database" do
          song = Song.find_or_register("2Foc5Q5nqNiosCNqttzHof")
          expect(song.name).to eq "Get Lucky - Radio Edit"
        end
      end
      describe "if song already exists" do
        it "should get the song" do
          song = FactoryGirl.create(:song)
          expect(Song.find_or_register(song.song_spotify_id)).to eq song
        end
      end
    end
  end
  context "instance methods" do
    context "save_prediction_info" do
      it "set index on prediction io" do
        song = FactoryGirl.create(:song)
        expect(song.save_prediction_info).not_to be_falsey
      end
    end
  end
end
