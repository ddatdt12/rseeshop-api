module ApiException
  module Handler
    def self.included(klass)
      klass.class_eval do
        rescue_from StandardError do |err|
          render status: 500, json: { error_code: 500, message: err.message }
        end

        ApiException::BaseError.descendants.each do |error_class|
          rescue_from error_class do |err|
            render status: err.status_code, json: { error_code: err.error_code, message: err.message }
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |err|
           render status: 404, json: { error_code: 404, message: "#{err.model} not found" }
        end
      end
    end
  end

  class BaseError < StandardError
    attr_reader :status_code, :error_code
  end

  class BadRequest < BaseError
    def initialize(msg = nil)
      @status_code = 400
      @error_code = 40101
      msg ||= "Bad request"
      super
    end
  end

  class Unauthorized < BaseError
    def initialize(msg = nil)
      @status_code = 401
      @error_code = 40101
      msg ||= "Unauthorized"
      super
    end
  end

  class Forbidden < BaseError
    def initialize(msg = nil)
      @status_code = 403
      @error_code = 40101
      msg ||= "Forbidden"
      super
    end
  end

  class NotFound < BaseError
    def initialize(msg = nil)
      @status_code = 404
      @error_code = 40101
      msg ||= "Not found"
      super
    end
  end

  class InternalServerError < BaseError
    def initialize(msg = nil)
      @status_code = 500
      @error_code = 40101
      msg ||= "Your own message in here"
      super
    end
  end
end
