class ManagersController < ApplicationController
  before_action :check_manager, :get_form

  def applicants
    @users = current_user.employees
  end

  def show_request
    @user = User.find(params[:id])
    @submissions = @user.submissions.pending
  end

  def set_status
    submission = Submission.find(params[:submission_id])
    if submission.update(status: params[:status])
      SubmissionMailer.send_submission_status(submission, params[:status], Rails.application.routes.url_helpers.submission_url(submission.id)).deliver_now
      flash.notice = 'Submission was successfully updated'
      redirect_to show_request_manager_path(id: params[:user_id])
    else
      flash.alert = 'Submission failed to update.'
    end
  end

  def get_form
    @form = Form.find_by(_type: "working")
  end

  def check_manager
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('project_manager')
  end
end