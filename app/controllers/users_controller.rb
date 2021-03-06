# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  last_name              :string
#  country                :string
#

require 'elasticsearch'

class UsersController < ApplicationController

  before_action :authenticate_user!

  def profile
    @user = current_user
    @recordings = @user.recordings.order(created_at: :desc)
  end

  def scroll
    client = Elasticsearch::Client.new log: true
    response = client.scroll(scroll: '5m', scroll_id: params[:scroll_id])['hits']['hits']
    response.delete_if{|x| x['_source']['song_id']==nil}
    songs_ids = response.collect {|r| r['_source']['song_id']}
    @songs = RSpotify::Track.find(songs_ids)
    @recordings = response.map do |r| 
      current_song = @songs.select {|song| song.id == r['_source']['song_id'] }
      r['song_info'] = current_song[0]
      r
    end
    respond_to do |format|
      format.js { render :template => '/users/scroll'}
    end
  end
end
