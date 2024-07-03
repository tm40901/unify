class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_sidebar_count

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number, 
                                                       :last_name,
                                                       :first_name,
                                                       :department,
                                                       :role])
  end

  def set_sidebar_count
    if current_user
      inspection_results = InspectionResult.where(status: 'Pending', approver_id: current_user.id)
      @count = inspection_results.group_by(&:custom_id).count
    end
  end
end
