module Error
  class ApiError < StandardError
    def initializer(message)
      @message = message
    end

    def response_code
      "500"
    end

    def response
      {
        errors: [
          {
            status: response_code,
            title:  title,
            detail: detail
          }
        ]
      }
    end

    def title
      ""
    end

    def detail
      return @message
    end

    def log_level
      "warn"
    end

  end
end