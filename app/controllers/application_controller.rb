class ApplicationController < ActionController::Base

  before_action :authenticate_user!, :set_user_role

  def after_sign_in_path(resource)
    default_path_for_user(resource)
  end

  def default_path_for_user(resource)
    debugger
    if resource.has_role?('admin')
      admin_root_path
    elsif resource.has_role?('accountant')
      accountants_path
    else
      submissions_path
    end
  end

  def set_user_role
    if current_user.present?
      role = current_user.role
      case role
      when 'project_manager'
        @active_role = 'managers'
      when 'accountant'
        @active_role = 'accountants'
      when 'admin'
        @active_role = 'admin'
      else
        @active_role = 'employees'
      end
    end
  end
end
