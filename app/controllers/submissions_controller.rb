class SubmissionsController < ApplicationController

  def new
    @form = Form.find_by(_type: params[:_type])
  end
  def create
    @submission = current_user.submissions.new(form_id: params[:form_id], data: params[:data])
    # debugger
    if @submission.save
      redirect_to employees_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end