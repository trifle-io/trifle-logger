# frozen_string_literal: true

module Trifle
  module Logger
    class Configuration
      attr_accessor :tracer_klass, :callbacks, :bump_every

      def initialize
        @tracer_klass = Trifle::Logger::Tracer::Hash
        @callbacks = { liftoff: [], bump: [], wrapup: [] }
        @bump_every = 15.seconds
      end

      def on_liftoff(tracer)
        @callbacks.fetch(:liftoff, []).map do |c|
          c.call(tracer)
        end
      end

      def on_bump(tracer)
        @callbacks.fetch(:bump, []).map do |c|
          c.call(tracer)
        end
      end

      def on_wrapup(tracer)
        @callbacks.fetch(:wrapup, []).map do |c|
          c.call(tracer)
        end
      end

      def on(event, &block)
        @callbacks[event] << block
      end
    end
  end
end
