require "raze"

module Onion
  class StaticFallback < Raze::Handler
    def initialize(option = {} of Symbol => String)
      @mode = options[:mode] || :off
      @static_path_regex = options[:static_path_regex] || %r{/system/(audios|photos|videos)}
      @fallback_static_url = options[:fallback_static_url] || String.empty

      if @mode == :fallback && !@fallback_static_url
        raise ArgumentError, "Rack::StaticFallback :mode => :fallback option specified without :fallback_static_url option"
      end
    end
    
    def call(ctx, done)
      path = ctx.request.path
      return done.call if !(path =~ @static_path_regex)
      case @mode
        when :off
          done.call
        when :bounce
          not_found
        when :fallback
          [ 302, { "Location" => ::File.join(@fallback_static_url, path) }, [] of String ]
      end
    end
    
    private def not_found
      [ 404, { "Content-Type" => "text/html", "Content-Length" => "0" }, [] of String ]
    end
  end
end