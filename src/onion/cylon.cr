require "raze"

module Onion
  class Cylon < Raze::Handler
    def call(ctx, done)
      if ctx.request.path == "/robots.txt" && Raze.config.env != "production"
        [200, {"Content-Type" => "text/plain"}, ["User-Agent: *\nDisallow: /"]]
      else
        done.call
      end
    end
  end
end