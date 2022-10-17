class AccountantsController < ApplicationController
  # TODO we will add account portal
  before_action :check_accountant

  def index
    @user = current_user
    @form = Form.find_by(_type: "working")
    @submissions = @user.submissions.where(form_id: @form.id)

  end

  def show
  end

  def employee_submissions
    @user = User.find(params[:id])
    @form = Form.find_by(_type: "working")
    @submissions = @user.submissions.where(form_id: @form.id)
  end

  def applicants
    @users = User.all
  end

  def user_submissions
    @user = User.find(params[:user_id])
    @submission = Submission.find(params[:submission_id])
    @submission.data = @submission.data.except('name_of_patient', 'relationship_with_employee','reporting_manager','name_of_patient','relationship_with_employee','project_name')
    respond_to do |format|
      format.html
      format.xlsx do
        @xlsx_file = generate_xlsx(@submission)
        send_file(@xlsx_file.path)
      end
    end
  end


  private

  def check_accountant
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('accountant')
  end

  def generate_xlsx(submission)
    file = Tempfile.new(%w[report .xlsx])
    workbook = WriteXLSX.new(file)
    worksheet = workbook.add_worksheet
    data = []
    data << submission.data.values.first.keys
    submission.data.values.each do |row|
      data << row.values
    end
    worksheet.write_col(0, 0, data)
    workbook.close
    file
  end
end