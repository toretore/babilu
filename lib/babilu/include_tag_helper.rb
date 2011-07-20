module Babilu
  module IncludeTagHelper
    def babilu_include_tag
      Babilu::Generator.generate

      javascript_include_tag 'locales.js'
    end
  end
end