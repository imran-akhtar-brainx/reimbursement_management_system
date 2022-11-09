class SubmissionsController < ApplicationController
  before_action :set_form

  def index
    @submissions = current_user.has_role?('accountant') ? Submission.all.order(created_at: :desc) : current_user.submissions.all
    @submissions = @submissions.where(user_id: params[:user_id]) if params[:user_id].present?
    @submissions = @submissions.where(form_id: params[:form_id]) if params[:form_id].present?
    @submissions = @submissions.where(created_at: Date.strptime(params['reportrange'].split(' - ', 2)[0], "%m/%d/%Y").beginning_of_day..Date.strptime(params['reportrange'].split(' - ', 2)[1], "%m/%d/%Y").end_of_day) if params[:reportrange].present?
    @pagy, @submissions = pagy(@submissions.order(created_at: :desc), items: 5)
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

  def generate_xlsx(submissions)
    file = Tempfile.new(%w[report .xlsx])
    workbook = WriteXLSX.new(file)
    worksheet = workbook.add_worksheet
    data = []
    data << csv_fields(submissions.first.attributes, "header")

    submissions.each do |submission|
      data << csv_fields(submission.attributes, "data-fields")
    end
    data << ["Grad Total: ", submissions.sum(:total).to_s]

    worksheet.write_col(0, 0, data)
    workbook.close
    file
  end

  def csv_fields(submission, type)
    fields = []
    if type == "header"
      fields.push("User Name")
      fields.push("Form Type")
    else
      fields.push(User.find(submission['user_id']).name.titleize)
      fields.push(Form.find(submission['form_id'])._type.titleize)
    end
    submission['data'] = submission['data'].except("name_of_patient", "relationship_with_employee", "project_name")
    submission.keys.each do |field|
      if field == "data"
        if type == "header"
          submission[field].first[1].keys.each do |key|
              fields.push(key.titleize)
          end
        else
          submission[field].each do |hash|
            debugger
            hash[1].values.each do |value|
              fields.push(value)
            end
          end
        end

      end
      if type == "header"
        fields.push(field.titleize)
      else
        fields.push(submission[field])
      end
    end
    fields
  end

end



