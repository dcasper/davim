PORTAL_PORT = 3000
API_PORT = 4000

project = ARGV[0]
command = ARGV[1]

case project
when "portal"
  port = PORTAL_PORT
when "api"
  port = API_PORT 
end

case command
when "server"
  rails_command = "rails server -p #{port}"
else
  rails_command = "rails #{command}"
end

exec "bundle exec #{rails_command}"
