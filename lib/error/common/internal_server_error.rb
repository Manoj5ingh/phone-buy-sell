module Error
  module Common
    class InternalServerError < ApiError
      def initialize(message)
        @message = message
      end

      def title
        "Internal Server Error"
      end

      def response_code
        "500"
      end

      def detail
        return @message
      end
    end
  end
end