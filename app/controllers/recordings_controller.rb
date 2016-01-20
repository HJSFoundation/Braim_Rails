class RecordingsController < ApplicationController
  def create
    data = params[:data]
    recording = params[:recording]
    new_recording = Recording.new
    new_recording.user_id = recording['user_id']
    new_recording.song_id = recording['song_id']
    new_recording.duration = recording['duration']
    new_recording.date = recording['date']

    if new_recording.save
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
        entry.date = r['date']
        entry.save
      end
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
    entries = Entry.all query: { match: { recording_id: id  } } ,sort: [
      {timestamp: {order: "asc", mode: "avg"}}]
    respond_to do |format|
      format.json { render json:  entries.to_json }
    end
  end

  def show
    id = params[:id]
    response = Recording.all query: { match: { _id: id  } } 
    recording = response.results[0]
    respond_to do |format|
      format.json { render json:  recording.to_json }
    end
  end

  def index
    @recordings = Recording.all_query(  params[:page].to_i,params[:per_page].to_i,params[:user_id].to_i,params[:song_id])
    respond_to do |format|
      format.json { render json:  @recordings.to_json }
    end
  end

  def destroy
    deleted_id = params[:recording_id]
    client = Elasticsearch::Client.new log: true
    client.delete index: 'braim', type: 'recording', id: deleted_id
    #TODO Fix delete all entries 
    client.delete_by_query index: 'braim', type: 'entry', q: "recording_id:#{deleted_id}"
    respond_to do |format|
      format.json { render json:  {deleted_id: deleted_id}.to_json }
    end
  end
end
