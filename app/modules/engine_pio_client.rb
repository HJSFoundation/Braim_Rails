class EnginePioClient
  def self.config_client
    @client = PredictionIO::EngineClient.new
    byebug
    @client.get_status()
  end
  def self.send_query(query = {})
    begin
      unless @client
        puts "New pio engine client created"
        self.config_client
      end
      @client.send_query(query)
    rescue PredictionIO::EngineClient::NotCreatedError
      self.config_client
      puts "Error in engine client"
      @client.send_query(query)
    end
  end
end