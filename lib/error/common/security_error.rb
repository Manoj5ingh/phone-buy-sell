module Error
  module Common
    class SecurityError < ApiError
      def title
        "Authentication issue"
      end

      def response_code
        "401"
      end

      def detail
        message
      end
    
    end
  end
end