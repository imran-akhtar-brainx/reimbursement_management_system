class AccountantsController < ApplicationController
  # TODO we will add account portal
  before_action :check_accountant
  def employees
    @users = User.joins(:roles).where.not('roles._type' => 'admin').order(:id).distinct
  end

  def user_submissions
    @submission = Submission.find(params[:submission_id])
    @user = @submission.user
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
    submission.data.values.each do |value|
      data << value.values
    end
    worksheet.write_col(0, 0, data)
    workbook.close
    file
  end
end