class SubmissionsController < ApplicationController

  #user for current user submission
  def employee_submissions
    @submissions = current_user.submissions.where(form_id: params[:form_id])
  end

  def index
    @submissions = Submission.all
  end

  def pending_submissions
    @submissions = User.find(params[:id]).submissions.where(status: "pending")
  end

  def new
    @form = Form.find_by(_type: params[:_type])
  end

  def create
    @submission = current_user.submissions.new(form_id: params[:form_id], data: params[:data], approved_by: current_user&.manager&.name, status: "pending")
    if @submission.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end