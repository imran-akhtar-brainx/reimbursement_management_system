class SubmissionsController < ApplicationController

  def index
    @submissions = Submission.all
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
      @form = Form.find_by(_type: params[:_type])
      render "forms/_#{params[:_type]}_form", status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
    @form = @submission.form
    @user = @submission.user
  end

  def requested_submission
    @submission = Submission.find(params[:id])
  end

  def employee_submissions
    @form = Form.find_by(_type: params[:_type])
    @submissions = current_user.submissions.where(form_id: @form.id)
  end

  #TODO: I will improve this function by removing the check statements
  def filtered
    @user = User.find(params[:user_id])
    @form = Form.find_by(_type: params[:_type])
    range = params['reportrange']
    range = range.split(' - ', 2)
    @submissions = @user.submissions.where(form_id: @form.id, created_at: Date.strptime(range[0], "%m/%d/%Y").beginning_of_day..Date.strptime(range[1], "%m/%d/%Y").end_of_day)
    render 'submissions/employee_submissions'
  end

  def pending_submissions
    @submissions = User.find(params[:id]).submissions.where(status: "pending")
  end

end