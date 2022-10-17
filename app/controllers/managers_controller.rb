class ManagersController < ApplicationController
  before_action :check_manager

  def index
    @user = current_user
    @form = Form.find_by(_type: "working")
    @submissions = @user.submissions.where(form_id: @form.id)
  end

  def requested_employees
    @users = User.where(manager_id: current_user.id)
  end

  def show_request
    @user = User.find(params[:id])
    @submissions = @user.pending_submissions(params[:id])
    @form = Form.find_by(_type: "working")
  end

  def set_status
    submission = Submission.find(params[:submission_id])
    submission.update(status: params[:status])
    redirect_to show_request_manager_path(id: params[:user_id])
  end

  def check_manager
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('project_manager')
  end
end