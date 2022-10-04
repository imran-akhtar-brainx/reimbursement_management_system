class ManagersController < ApplicationController
  before_action :check_manager

  def index
  end

  def show
    @users = User.where(manager_id: current_user.id)
  end

  def my_submitted_forms
    @submissions = current_user.submissions.where(form_id: params[:form_id])
  end

  def show_request
    @submissions = User.find(params[:user_id]).submissions.joins(:form).where(form: {_type: "working"})
    # user = User.find(params[:user_id])
    # @submissions = users.forms.where(_type: "working")
  end

  def submitted_forms
    @submissions = current_user.submissions
  end

  def set_status
    submission = Submission.find(params[:submission])
    submission.update(status: params[:status] )
    redirect_to show_request_manager_path
  end

  def check_manager
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('project_manager')
  end
end