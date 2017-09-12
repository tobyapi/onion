require "./onion/*"
require "raze"

get "/hello" do |ctx|
  "hello, world!"
end

get "/heartbeat", Onion::Heartbeat.new

Raze.run