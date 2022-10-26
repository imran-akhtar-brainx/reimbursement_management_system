class SubmissionsController < ApplicationController
  def employee_submissions
    @user = User.find(params[:user_id])
    @form = Form.find_by(_type: params[:_type])
    @submissions = @user.submissions.where(form_id: @form.id)
  end

  #TODO: I will improve this function by removing the check statements 
  def filtered
    @user = User.find(params[:user_id])
    @form = Form.find_by(_type: params[:_type])
    if params[:date] == "today"
      @submissions = @user.submissions.where(form_id: @form.id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
    elsif params[:date] == "week"
      @submissions = @user.submissions.where(form_id: @form.id, created_at: Time.zone.today.beginning_of_week..Time.zone.today.end_of_week)
    elsif params[:date] == "month"
      @submissions = @user.submissions.where(form_id: @form.id, created_at: Time.zone.today.beginning_of_month..Time.zone.today.end_of_month)
    else
      range = params['daterange']
      range = range.split(' - ', 2)
      @submissions = @user.submissions.where(form_id: @form.id, created_at: Time.find_zone("UTC").parse(range[0])..Time.find_zone("UTC").parse(range[1]).end_of_day)
    end
    render 'submissions/employee_submissions'
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
      @form = Form.find_by(_type: params[:_type])
      render "forms/_#{params[:_type]}_form", status: :unprocessable_entity
    end
  end

  private

end