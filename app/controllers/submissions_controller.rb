class SubmissionsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    # debugger
    @submission = current_user.submissions.new(form_id: params[:form_id], data: params[:data])
    if @submission.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end