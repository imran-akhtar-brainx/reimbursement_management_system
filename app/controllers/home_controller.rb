class HomeController < ApplicationController
  def index
    # redirect_to user_sign_in? :home/index
    redirect_to user_signed_in? ? default_user_path(current_user) : new_user_session_path
  end
end
