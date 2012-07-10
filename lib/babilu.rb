require "lucy"
require "i18n_extensions"
module Babilu

  JAVASCRIPT = File.read(File.join(File.dirname(__FILE__), 'javascripts', 'babilu.js'))

  def self.generate
    Lucy.generate("locales") do |g|
      g.namespace = "I18n"
      g.write(:defaultLocale, default_locale)
      g.write(:translations, translations)
      g << methods
    end
  end

  # Searches for I18n.t calls and it extracts and array of strings
  # to be used to generate the locales.js file
  def self.grep_javascript_files
    grep_output = ""
    Dir.glob("public/**/**").select {|file| File.file?(file)}.each do |file|
      File.open(file, 'r').each_with_index do |line, index|
        grep_output += line if line.include?('I18n.t(') || line.include?('I18n.translate(')
      end
    end
    result = []
    result += grep_output.scan(/I18n\.t\('([\w+|\.+]+)'\)/) # captures I18n.t('a.key')
    result += grep_output.scan(/I18n\.translate\('([\w+|\.+]+)'\)/) # captures I18n.t('a.key')    
    result += grep_output.scan(/I18n\.t\(\"([\w+|\.+]+)\"\)/) # captures I18n.t("a.key")
    result += grep_output.scan(/I18n\.translate\(\"([\w+|\.+]+)\"\)/) # captures I18n.translate("a.key")    
    result.flatten
  end

  # Greps all the javascript files in public/
  # and uses the I18n calls to generate locales.js
  def self.translations
    result = {}
    needed_keys = grep_javascript_files
    I18n.all_translations.each_key do |key|
      result[key] = filter(I18n.all_translations[key], needed_keys)  
    end
    result
  end

  # the map will have all the translations 
  # the keys_array will have strings like 'auctions.auction.current_price'
  def self.filter(map, keys_array)
    unless keys_array.empty?
      filtered_map = map.select{ |key,value| keys_array.index { |string| string.index('.') ? string.start_with?("#{key}.") : string.start_with?("#{key}") }}
      result = {}
      filtered_map.each do |tuple|
        key = tuple[0] # because hash#select returns an array
        if map[key].class == Hash
          result[key] = filter(map[key], keys_array.collect { |s| s.index('.') ? s[s.index('.') + 1, s.length] : nil}.compact)  
        else
          result[key] = map[key] if keys_array.include?(key.to_s)
        end      
      end
      result      
    else
      nil
    end
  end

  def self.default_locale
    I18n.default_locale
  end

  def self.methods
    JAVASCRIPT
  end


  module ControllerMethods

    def self.included(controller)
      controller.send(:after_filter, :set_locale_cookie)
      controller.send(:after_filter, :generate_locale_javascript) if Rails.env.development?
    end

  private

    def set_locale_cookie
      cookies[:locale] = I18n.locale.to_s
    end

    #In development mode, re-generate locale data on each request
    def generate_locale_javascript
      Babilu.generate
    end

  end

  class Railtie < Rails::Railtie
    config.before_configuration do
      config.action_view.javascript_expansions[:defaults] ||= [] << 'locales'
    end
  end if defined?(Rails::Railtie)

end

ActionController::Base.send(:include, Babilu::ControllerMethods)
