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

class RecordingsController < ApplicationController
  before_action :authenticate_user!
  def create
    data = params[:data]
    recording = params[:recording]
    new_recording = Recording.new
    new_recording.user_id = recording['user_id']
    new_recording.song_id = recording['song_id']
    new_recording.duration = recording['duration']
    new_recording.date = Time.at(recording['date']/1000)
    #byebug
    if new_recording.save
      #client = PioClient.new_client
      total_entries = []
      data.each do |r|
        entry = Entry.new
        entry.recording_id = new_recording.id
        entry.user_id = r['user_id']
        entry.song_id = r['song_id']
        entry.interest = r['interest']
        entry.engagement = r['engagement']
        entry.focus = r['focus']
        entry.relaxation = r['relaxation']
        entry.instantaneousExcitement = r['instantaneousExcitement']
        entry.longTermExcitement = r['longTermExcitement']
        entry.stress = r['stress']
        entry.timestamp = r['timestamp']
        entry.date = Time.at(r['date'])
        entry.signal_quality = r['signal_quality']
        entry.event_id = entry.save_prediction_info
        total_entries.push(entry)
      end
      #Entry.save_prediction_batch(new_recording.id,total_entries)
      Entry.masive_record(total_entries)
      respond_to do |format|
        format.json { render json: { :response => "ok" ,length: data.length, recording: new_recording}.to_json }
      end
    else
      respond_to do |format|
        format.json { render json: { :response => "false" ,length: 0}.to_json }
      end
    end
  end

  def show_data
    id = params[:id]
    entries = Recording.find(id).entries
    respond_to do |format|
      format.json { render json:  entries.to_json }
    end
  end

  def destroy
    deleted_id = params[:recording_id]
    recording = Recording.find(deleted_id)
    entries = recording.entries
    entries.each do |entry|
      entry.delete_from_prediction
      entry.destroy
    end
    recording.destroy
    #TODO Fix delete all entries 
    #client.delete_by_query index: 'braim', type: 'entry', q: "recording_id:#{deleted_id}"
    respond_to do |format|
      format.json { render json:  {deleted_id: deleted_id}.to_json }
    end
  end
end
