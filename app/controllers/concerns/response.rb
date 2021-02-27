module Response
  def success_response(resource, status = :ok, message = nil)
    resource.merge!(message: message) unless message.nil?
    render json: resource, status: status
  end

  def error_response(resource, status = :bad_request)
    render json: {
      error: resource.errors.full_messages.to_sentence
    }, status: status
  end

  def exception_response(exception, status = :internal_server_error)
    render json: {
      error: exception.message
    }, status: status
  end
end
