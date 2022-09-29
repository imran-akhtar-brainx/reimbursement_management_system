class ManagersController < ApplicationController
  before_action :authenticate_user!

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

end