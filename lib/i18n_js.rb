module I18nJs

  JAVASCRIPT = File.read(File.join(File.dirname(__FILE__), 'javascripts', 'i18n.js'));

  def self.generate
    Lucy.generate("locales") do |g|
      g.namespace = "I18n"
      g.write :defaultLocale, default_locale
      g.write :translations, translations
      g.write_raw methods
    end
  end

  def self.translations
    I18n.backend.send(:init_translations) unless I18n.backend.send(:initialized?)
    I18n.backend.send :translations
  end

  def self.default_locale
    I18n.default_locale
  end

  def self.methods
    JAVASCRIPT
  end

end
