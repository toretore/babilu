module I18n
  class << self
    def available_locales
      backend.available_locales
    end
    def all_translations
      backend.all_translations
    end
  end

  module Backend
    class Simple
      def available_locales
        send(:init_translations) unless initialized?
        translations.keys
      end
      def all_translations
        send(:init_translations) unless initialized?
        translations
      end
    end
  end
end
