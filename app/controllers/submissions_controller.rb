class SubmissionsController < ApplicationController
  before_action :set_form

  def index
    @submissions = current_user.has_role?('accountant') ? Submission.all.order(created_at: :desc) : current_user.submissions.all
    @submissions = @submissions.where(user_id: params[:user_id]) if params[:user_id].present?
    @submissions = @submissions.where(form_id: params[:form_id]) if params[:form_id].present?
    @submissions = @submissions.where(created_at: Date.strptime(params['reportrange'].split(' - ', 2)[0], "%m/%d/%Y").beginning_of_day..Date.strptime(params['reportrange'].split(' - ', 2)[1], "%m/%d/%Y").end_of_day) if params[:reportrange].present?
    @submissions = @submissions.order(created_at: :desc)
    respond_to do |format|
      format.html do
        @pagy, @submissions = pagy(@submissions, items: 5)
      end
      format.xlsx do
        @xlsx_file = generate_xlsx
        send_file(@xlsx_file.path)
      end
    end
  end

  def new
  end

  def create
    @submission = current_user.submissions.new(submission_params.merge(form_id: @form.id, approved_by: current_user&.manager&.name))
    @submission.status = "pending" if (@form._type == "working")
    @submission.total = submission_total(@submission)
    if @submission.save!
      SubmissionMailer.send_submission_link(@submission, current_user.manager, Rails.application.routes.url_helpers.submission_url(@submission.id)
      ).deliver_now if @form._type == "working" && current_user.manager.present?
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

  def set_form
    @form = Form.find(params[:form_id].present? ? params[:form_id] : Form.find_by(_type: "working").id)
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
    submission.data.values.each do |key, value|
      sum += (key['amount'].to_i)
    end
    sum
  end

  def generate_xlsx
    file = Tempfile.new(%w[report .xlsx])
    workbook = WriteXLSX.new(file)
    worksheet = workbook.add_worksheet
    @data = []
    @data << ["submission Id", "Employee Id", "Employee Name", "Form Type", "Date", "Day", "Reason Of Working", "Nature Of Holiday", "Name Of Patient", "Relationship With Employee", "Project Name", "Description", "Amount", "Created At", "Updated At", "Status", "Approved By"]
    @submissions.each do |submission|
      csv_fields(submission)
    end
    worksheet.write_col(0, 0, @data)
    workbook.close
    file
  end

  def csv_fields(submission)
    fields = ["date", "day", "reason_of_working", "nature_of_holiday", "name_of_patient", "relationship_with_employee", "project_name", "description", "amount"]
    user = submission.user
    form = submission.form._type
    form_row_fields = {}
    form_single_fields = {}
    submission['data'].each do |key, values|
      if values.is_a? String
        form_single_fields["#{key}"] = values
      else
        form_row_fields["#{key}"] = values
      end
    end
    form_row_fields.each do |key, values|
      arr = []
      arr << submission.id
      arr << user.emp_id
      arr << user.name
      arr << form
      fields.each do |field|
        if values[field].present?
          arr << values[field]
        else
          arr << form_single_fields[field]
        end
      end
      arr << submission.created_at
      arr << submission.updated_at
      arr << submission.status
      arr << submission.approved_by
      @data << arr
    end
  end

end



