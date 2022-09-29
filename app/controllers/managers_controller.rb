class ManagersController < ApplicationController
  before_action :check_manager

  def index
  end

  def check_manager
    redirect_to default_path_for_user(current_user) unless current_user.has_role?('project_manager')
  end
end