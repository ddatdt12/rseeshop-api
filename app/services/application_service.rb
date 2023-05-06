# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).__send__(:perform)
  end

  def perform
    raise NotImplementedError
  end

  private_class_method :new
end
