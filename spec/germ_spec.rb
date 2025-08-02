# frozen_string_literal: true

require 'spec_helper'

module Germ
  RSpec.describe Base do
    describe 'Base class' do
      subject(:germ) { klass.germinate }

      let(:klass) do
        class_name = generate(:class_name)

        Class.new(described_class) do
          Object.const_set(class_name, self)

          def group
            Struct.new(:name).new('Germ Test')
          end
        end
      end

      describe '#new' do
        it 'creates a seed' do
          expect(germ.group.name).to eq('Germ Test')
        end

        it 'memoizes public instance methods in seed' do
          instance = germ.group
          expect(germ.group).to be(instance)
        end

        context 'when data is passed as an option' do
          subject(:germ) { klass.new(data: { name: }) }

          let(:klass) do
            super().tap do |klass|
              klass.define_method(:group) do
                Struct.new(:name).new(name)
              end
            end
          end

          let(:name) { 'Some other germ name' }

          it 'can reference data as a missing method' do
            expect(germ.group.name).to eq('Some other germ name')
          end

          it 'fails if the data is missing' do
            expect { klass.new.group.name }.to raise_error(NameError)
          end
        end
      end
    end
  end
end
