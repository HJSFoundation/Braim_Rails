class PioClient
  def self.config_client
    @client = PredictionIO::EventClient.new(ENV['PIO_ACCESS_KEY'], ENV['PIO_EVENT_SERVER_URL'], Integer(ENV['PIO_THREADS']))
  end
  def self.create_event(event,entity_type,entity_id,properties = {})
    begin
      unless @client
        puts "New pio client created"
        self.config_client
      end
      @client.create_event(event,entity_type,entity_id,properties)
    rescue PredictionIO::EventClient::NotCreatedError
      self.config_client
      puts "Error in client"
      @client.create_event(event,entity_type,entity_id,properties)
    end
  end
end

