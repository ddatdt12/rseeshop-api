# Error module to Handle errors globally
# include Error::ErrorHandler in application_controller.rb
module ErrorHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    end
  end

  private

  def record_not_found(_e)
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end