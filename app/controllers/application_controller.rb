class ApplicationController < ActionController::Base

  before_action :authenticate_user!, :set_user_role

  def after_sign_in_path(resource)
    default_path_for_user(resource)
  end

  def default_path_for_user(resource)
    if resource.has_role?('project_manager')
      managers_path
    elsif resource.has_role?('accountant')
      accountants_path
    else
      employees_path
    end
  end

  def set_user_role
    if current_user.present?
      role = current_user.role
      @active_role = if role == 'project_manager'
                       'managers'
                     elsif role == 'accountant'
                       'accountants'
                     else
                       'employees'
                     end
    end
  end

end
