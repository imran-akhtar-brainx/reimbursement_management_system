module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!, :authenticate_admin

    def authenticate_admin
      redirect_to root_path unless current_user.has_role?('admin')
    end
  end
end
