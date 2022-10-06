class ApplicationController < ActionController::Base

  before_action :authenticate_user!

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

end
