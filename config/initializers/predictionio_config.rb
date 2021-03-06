require 'predictionio'

# Define environment variables.
ENV['PIO_THREADS'] = '1' # For async requests.
ENV['PIO_EVENT_SERVER_URL'] = 'http://localhost:7070'
ENV['PIO_ACCESS_KEY'] = Rails.application.secrets.prdictionio_access_key # Find your access key with: `$ pio app list`.
ENV['PIO_ENGINE_URL'] = 'http://localhost:8000'

# Create PredictionIO event client.
#::PIO_CLIENT = PredictionIO::EventClient.new(ENV['PIO_ACCESS_KEY'], ENV['PIO_EVENT_SERVER_URL'], Integer(ENV['PIO_THREADS']))