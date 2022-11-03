class EmployeesController < ApplicationController
  before_action :check_employee


  private

  def check_employee
    redirect_to default_path_for_user(current_user) if current_user.has_role?('project_manager') || current_user.has_role?('admin') || current_user.has_role?('accountant')
  end
end