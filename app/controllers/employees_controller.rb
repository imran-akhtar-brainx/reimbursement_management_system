class EmployeesController < ApplicationController
  before_action :check_employee

  def index
  end

  def submitted_forms
    @forms = Form.all
  end

  def show
  end

  def form_submissions
    @submissions = current_user.submissions.where(form_id: params[:form_id])
  end

  private

  def check_employee
    redirect_to default_path_for_user(current_user) if current_user.has_role?('project_manager') || current_user.has_role?('accountant')
  end
end