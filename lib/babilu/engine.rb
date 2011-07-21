module Babilu
  class Engine < Rails::Engine
    initializer 'babilu.generate_locales' do
      Babilu::Generator.generate
    end
  end
end