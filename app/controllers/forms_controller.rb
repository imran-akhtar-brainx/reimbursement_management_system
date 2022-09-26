class FormsController < ApplicationController
  before_action :authenticate_user!
  def index
    # debugger
    @forms = Form.all
    # @user = User.find(params[:id])
  end

  def new
    # debugger
    # @form_id = params[:id]
    # @user = current_user
    @form = Form.find_by(_type: params[:_type])
  end

  def create
    debugger
    @submission = Submission.new
    @form =  Form.new(_type: "..", data: {})
    if @form.save
      redirect_to @form
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @forms = Form.find(params[:id])
  end
end
