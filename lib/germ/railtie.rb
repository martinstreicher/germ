# frozen_string_literal: true

class Railtie < Rails::Railtie
  initializer 'germ.paths' do
    Gem.paths << "db/seeds/#{Rails.env}"
  end
end
