require 'memo_wise'

module Germ
  class Base
    prepend MemoWise

    HIDDEN_METHODS = %w[germinate reset].freeze

    def self.germinate(**args)
      new(**args).germinate
    end

    ##
    # options:
    #   data: Data to seed with
    #   ignore: Array of method names to ignore
    ##
    def initialize(**options)
      @options = options
      @options = default_options if @options.empty?
      @options = @options.deep_symbolize_keys
    end

    def germinate
      seed
      self
    end

    def reset
      ##
      ## Track changes in seeded models and reset any with changes?
      ## Not sure if this is possible without wholesale recreation due to
      ## associations. Simplest implemetation is to just destroy and recreate
      ## the entire germ.
      raise NotImplementedError, 'Each subclass must implement `reset`'
    end

    private

    attr_reader :options

    def default_options = {}

    def method_missing(method, ...)
      options.dig(:data, method.to_sym) || super
    end

    def public_method_names
      self
        .class
        .public_instance_methods(false)
        .reject { |method| HIDDEN_METHODS.include?(method.to_s) }
        .reject { |method| (options[:ignore] || []).include?(method.to_s) }
        .tap { |methods| methods.each { self.class.memo_wise(_1.to_sym) } }
    end

    def reset_seeded_models
      raise NotImplementedError, 'Each subclass must implement `reset_seeded_models`'
    end

    def respond_to_missing?(_method_name, _include_private = false)
      options.dig(:data, method.to_sym)
    end

    def seed = public_method_names.each { public_send(_1) }
  end
end
