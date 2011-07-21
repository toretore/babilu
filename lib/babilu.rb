require "lucy"
require "babilu/i18n_extensions"
require "babilu/generator"
require "babilu/include_tag_helper"
require "babilu/engine"

ActionController::Base.send(:include, Babilu::Generator)
ActionView::Base.send(:include, Babilu::IncludeTagHelper)
