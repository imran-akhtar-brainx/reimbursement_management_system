class AccountantsController < ApplicationController
  # TODO we will add account portal
  before_action :check_accountant

  def employees
    @users = User.joins(:roles).where.not('roles._type' => 'admin').order(:id).distinct
  end

  def user_submissions
    @submission = Submission.find(params[:submission_id])
    @user = @submission.user
  end

  private

  def check_accountant
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('accountant')
  end

end