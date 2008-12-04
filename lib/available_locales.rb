module I18n
  class << self
    def available_locales
      backend.available_locales
    end
  end

  module Backend
    class Simple
      def available_locales
        send(:init_translations) unless initialized?
        translations.keys
      end
    end
  end
end
