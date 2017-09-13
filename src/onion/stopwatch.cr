require "raze"
require "time"
require "logger"

module Onion
  class Proxy < Raze::Handler
    def initialize(@logger : Logger)
    end

    def call(ctx, done)
      start = Time.now
      response = done.call
      finish = Time.now
      @logger.debug("%.8f ms" % (finish - start).to_f * 1000)
      response
    end
  end
end
