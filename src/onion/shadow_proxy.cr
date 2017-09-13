require "raze"
require "http"


module Onion
  class ShadowProxy < Raze::Handler
    def initialize(backends : Array(URI))
      @backends = backends.map { |backend| HTTP::Client.new(backend)  }
    end

    def def initialize(@backends : Array(HTTP::Client))
    end

    def call(ctx, done)
      @backends.each { |backend| backend.exec(ctx.request) }
      done.call
    end
  end
end
