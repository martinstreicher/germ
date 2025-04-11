# frozen_string_literal: true

module Germ
  module Seed
    include FactoryBot::Syntax::Methods

    def self.included(base)
      debugger
      Internals.register(name: base.name, seed: self)
    end
  end
end
