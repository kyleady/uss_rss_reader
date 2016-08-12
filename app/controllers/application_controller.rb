# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
