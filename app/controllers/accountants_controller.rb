class AccountantsController < ApplicationController
  # TODO we will add account portal
  before_action :check_accountant

  def index

  end

  def my_submitted_forms
    @submissions = current_user.submissions.where(form_id: params[:form_id])
  end

  def show
    @user = User.find(params[:id])
    @submissions = @user.submissions.where(form_id: params[:form_id])
  end

  def applicants
    users_ids = Submission.pluck(:user_id).uniq
    @users = User.where(id: users_ids)

  end

  def user_submissions
    @user = User.find(params[:user_id])
    @submissions = @user.submissions.where(form_id: params[:form_id])
    if params[:_type] == "working"
      @submissions = @user.submissions.where(form_id: 2, status: "approved")
    else
      @submissions = @user.submissions.where(form_id: params[:form_id])
    end
    respond_to do |format|
      format.html
      format.xlsx do
        @xlsx_file = generate_xlsx(@submissions)
        send_file(@xlsx_file.path)
      end
    end
  end



  def submitted_forms
    @submissions = current_user.submissions
  end

  private

  def check_accountant
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('accountant')
  end

  def generate_xlsx(submissions)
    file = Tempfile.new(%w[report .xlsx])
    workbook = WriteXLSX.new(file)
    # Add a worksheet
    worksheet = workbook.add_worksheet

    data = []
    data << submissions.first.data.keys
    submissions.each do |submission|
      data << submission.data.values
    end
    worksheet.write_col(0, 0, data)
    workbook.close
    file
  end
end