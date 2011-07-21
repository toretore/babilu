module Babilu
  class Railtie < Rails::Railtie
    # We need to hook our initializer after the point at which locales have been loaded.
    config.after_initialize do
      Babilu::Generator.generate
    end
  end
end
