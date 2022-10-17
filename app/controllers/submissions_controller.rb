class SubmissionsController < ApplicationController

  #user for current user submission
  def employee_submissions
    @user = User.find(params[:user_id])
    @form = Form.find_by(_type: params[:_type])
    @submissions = @user.submissions.where(form_id: @form.id)
  end

  def show
    @submission = Submission.find(params[:id])
    @form = Form.find(@submission.form_id)
    @user = User.find(params[:user_id])
  end

  def requested_submission
    @submission = Submission.find(params[:id])
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
    form = Form.find_by(_type: params[:_type])
    @submission = current_user.submissions.new(form_id: form.id, data: params[:data], approved_by: current_user&.manager&.name, images: params[:images])
    if (form._type == "working")
      @submission.status = "pending"
    end
    if @submission.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end