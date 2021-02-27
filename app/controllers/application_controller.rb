class ApplicationController < ActionController::API
  include ExceptionHandler
  include Response
  include Pagy::Backend
end
