# frozen_string_literal: true

require 'trifle/logger/configuration'
require 'trifle/logger/tracer/hash'
require 'trifle/logger/tracer/null'
require 'trifle/logger/middleware/rack'
require 'trifle/logger/middleware/rails_controller'
require 'trifle/logger/middleware/sidekiq'
require 'trifle/logger/version'

module Trifle
  module Logger
    class Error < StandardError; end
    # Your code goes here...

    def self.default
      @default ||= Configuration.new
    end

    def self.configure
      yield(default)

      default
    end

    def self.tracer=(tracer)
      Thread.current[:trifle_tracer] = tracer
    end

    def self.tracer
      Thread.current[:trifle_tracer]
    end

    def self.trace(*args, **keywords, &block)
      return unless tracer

      tracer.trace(*args, **keywords, &block)
    end

    def self.tag(tag)
      return unless tracer

      tracer.tag(tag)
    end

    def self.fail!
      return unless tracer

      tracer.fail!
    end
  end
end
