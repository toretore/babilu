module Babilu
  module Generator
    JAVASCRIPT_RUNTIME = File.read(File.join(File.dirname(__FILE__), '..', 'javascripts', 'babilu.js'))

    class << self
      def included(base)
        base.send :extend, ClassMethods
      end

      def generate
        generate! unless reuse_locales?
      end

      def generate!
        I18n.reload!

        Lucy.generate("locales") do |gen|
          gen.namespace = "I18n"
          gen[:defaultLocale] = I18n.default_locale
          gen[:translations]  = I18n.all_translations
          gen << JAVASCRIPT_RUNTIME
        end

        @locales_generated = true
      end

      def reuse_locales?
        if Rails.env.production?
          @locales_generated
        else
          false
        end
      end
    end

    module ClassMethods
      def self.included(controller)
        controller.send(:after_filter, :set_locale_cookie)
      end

      private

      def set_locale_cookie
        cookies[:locale] = I18n.locale.to_s
      end
    end
  end
end