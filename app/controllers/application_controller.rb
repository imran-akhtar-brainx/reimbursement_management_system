class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    # debugger
    if resource.has_role?('project_manager')
        managers_path
    elsif resource.has_role?('accountant')
        accountants_path
    else
        employees_path
      end

    end
end

