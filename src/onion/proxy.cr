require "raze"
require "http"


module Onion
  class Proxy < Raze::Handler

    def initialize(backend : URI)
      @backend = HTTP::Client.new(backend)
    end

    def initialize(@backend : HTTP::Client)
    end

    def call(ctx, done)
      ctx.request.headers.add("X-Forwarded-For", Raze::Config.host)
      @backend.exec(ctx.request)
    end
  end
end
