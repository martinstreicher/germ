require 'spec_helper'

module Germ
  RSpec.describe Internals do
    let(:class_name) { 'Germx' }

    let(:klass) do
      Class.new do
        Object.const_set(:Germx, self)
        include Germ::Seed
      end
    end

    describe '.register' do
      context 'when a class includes the seed' do
        it 'registers the class name and seed' do
          klass

          expect(described_class.classes[class_name]).to be_truthy
          expect(described_class.classes[class_name][:seed]).to eq(Seed)
        end
      end
    end
  end
end
