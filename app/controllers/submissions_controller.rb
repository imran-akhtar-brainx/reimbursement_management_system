class SubmissionsController < ApplicationController
  before_action :set_form

  def index
    @forms = Form.all
    @users = User.all
    @submissions = Submission.all.order(created_at: :desc)
    @submissions = @submissions.where(user_id: params[:user_id]) if params[:user_id].present?
    @submissions = @submissions.where(form_id: params[:form_id]) if params[:form_id].present?
    @submissions = @submissions.where(created_at: Date.strptime(params['reportrange'].split(' - ', 2)[0], "%m/%d/%Y").beginning_of_day..Date.strptime(params['reportrange'].split(' - ', 2)[1], "%m/%d/%Y").end_of_day) if params[:reportrange].present?
    respond_to do |format|
      format.html
      format.xlsx do
        @xlsx_file = generate_xlsx(@submissions)
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

  def generate_xlsx(submissions)

    file = Tempfile.new(%w[report .xlsx])
    workbook = WriteXLSX.new(file)
    worksheet = workbook.add_worksheet
    data = []
    data << csv_fields(submissions.first)
    submissions.each do |submission|
      data << data_fields(submission)
    end
    worksheet.write_col(0, 0, data)
    workbook.close
    file
  end


  def data_fields(submission)
    fields = []
    submission.attributes.keys.each do |field|
      if field == "data"
        submission.attributes[field].values.first.values.each do |key|
          fields.push(key)
        end
      else
        fields.push(submission.attributes[field])
      end
    end
    fields
  end

  def csv_fields(submission)
    fields = []
    submission.attributes.keys.each do |field|
      if field == "data"
        submission.attributes[field].values.first.keys.each do |key|
          fields.push(key)
        end
      else
        fields.push(field)
      end
    end
    fields
  end

end