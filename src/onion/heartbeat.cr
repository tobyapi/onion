require "raze"

module Onion
  class Heartbeat < Raze::Handler
    @@heartbeat_path = "heartbeat"
    @@heartbeat_response = "OK"
    @@heartbeat_headers = {"Content-Type" => "text/plain"}
    
    def heartbeat_path
      @@heartbeat_path
    end
    
    def heartbeat_response
      @@heartbeat_response
    end
    
    def heartbeat_headers
      @@heartbeat_headers
    end
    
    def heartbeat_path=(path)
      @@heartbeat_path = path
    end
    
    def heartbeat_response=(response)
      @@heartbeat_response = response
    end
    
    def heartbeat_headers=(headers_hash)
      @@heartbeat_headers = headers_hash
    end
    
    def call(ctx, done)
      return done.call if ctx.request.path != "/#{heartbeat_path}"
      [200, heartbeat_headers, [heartbeat_response]]
    end
  end
end