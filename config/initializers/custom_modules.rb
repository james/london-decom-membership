require 'devise_bootstrap_views_helper'
require 'time_as_words'

ActionView::Base.send :include, DeviseBootstrapViewsHelper
ActionView::Base.send :include, TimeAsWords
