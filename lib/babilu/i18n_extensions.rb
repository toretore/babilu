I18n.module_eval do
  def self.all_translations
    backend.all_translations
  end
end

I18n::Backend::Simple.module_eval do
  def all_translations
    send(:init_translations) unless initialized?
    translations
  end
end
