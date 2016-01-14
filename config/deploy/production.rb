set :stage, :production
set :branch , 'master'
set :deploy_to, '/home/braim-pro/code/Braim_Rails'

# Replace 127.0.0.1 with your server's IP address!
server '40.78.19.2', user: 'braim-pro', roles: %w{web app}, my_property: :my_value

