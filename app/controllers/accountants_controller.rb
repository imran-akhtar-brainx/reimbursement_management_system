class AccountantsController < ApplicationController
  # TODO we will add account portal
  before_action :check_accountant
  def index
  end

  def check_accountant
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('accountant')
  end
end