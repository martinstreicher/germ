module Germ
  class Internals
    def self.classes
      @classes ||= {}
    end

    def self.register(**options)
      classes[options[:name]] = options
    end
  end
end
