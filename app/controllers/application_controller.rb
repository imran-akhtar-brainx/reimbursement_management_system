class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    # debugger
    default_user_path(resource)
  end

  # def after_sign_out_path_for(resource)
  #   new_session_path(resource)
  # end


  def default_user_path(resource)
    if resource.has_role?('project_manager')
      managers_path
    elsif resource.has_role?('accountant')
      accountants_path
    else
      employees_path
    end
  end

end