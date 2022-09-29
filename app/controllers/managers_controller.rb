class ManagersController < ApplicationController
  before_action :check_manager

  def index
    # debugger
  end

  def show
    # @user_ids = User.where(manager_id: current_user.id).pluck(:id)
    @users = User.where(manager_id: current_user.id)
    # @submissions = User.find(params[:user_id]).submissions.joins(:form).where(form: {_type: "working"})
    # @submissions = Submission.where(user_id: @user_ids)
  end

  def show_request
    @submissions = User.find(params[:user_id]).submissions.joins(:form).where(form: {_type: "working"})
    # debugger
  end

  def set_status
    # debugger
    submission = Submission.find(params[:submission])
    submission.update(status: params[:status] )
    redirect_to action: show_request
  end

  def check_manager
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('project_manager')
  end
end