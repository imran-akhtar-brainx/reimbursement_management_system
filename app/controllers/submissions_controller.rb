class SubmissionsController < ApplicationController
  before_action :set_form

  def index
    @submissions = current_user.submissions.where(form_id: @form.id)
  end

  def new
  end

  def create
    @submission = current_user.submissions.new(submission_params.merge(form_id: @form.id, approved_by: current_user&.manager&.name))
    @submission.status = "pending" if (@form._type == "working")
    @submission.total = submission_total(@submission)
    if @submission.save!
      flash.notice = 'Submission was successfully created.'
      redirect_to submissions_path
    else
      flash.alert = 'Submission failed to save.'
      render "forms/_#{params[:_type]}_form", status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def user_submissions
    @user = User.find(params[:id])
    @submissions = @user.submissions.where(form_id: @form.id)
  end

  #TODO: I will improve this function by removing the check statements
  def filtered
    @user = User.find(params[:user_id])
    range = params['reportrange']
    range = range.split(' - ', 2)
    @submissions = @user.submissions.where(form_id: @form.id, created_at: Date.strptime(range[0], "%m/%d/%Y").beginning_of_day..Date.strptime(range[1], "%m/%d/%Y").end_of_day)
    render 'submissions/index'
  end

  def set_form
    @form = Form.find_by(_type: params[:_type].present? ? params[:_type] : "working")
    @forms = Form.all
  end

  def pending_submissions
    @submissions = User.find(params[:id]).submissions.where(status: "pending")
  end

  private

  def submission_params
    params.permit(images: [], :data => {})
  end

  def submission_total(submission)
    sum = 0
    submission.data = submission.data.except('name_of_patient', 'relationship_with_employee', 'reporting_manager', 'name_of_patient', 'relationship_with_employee', 'project_name')
    submission.data.values.each do |key, value|
      sum += (key['amount'].to_i)
    end
    sum
  end
end