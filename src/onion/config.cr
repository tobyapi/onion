require "raze"

module Onion
  class Config < Raze::Handler
    def initialize(&@block : HTTP::Server::Context -> )
    end
    
    def call(ctx, done)
      @block.call(ctx)
      done.call
    end
  end
end