class FormsController < ApplicationController
  before_action :authenticate_user!

  def index
    @forms = Form.all
  end

  def new
    @form = Form.find_by(_type: params[:_type])
  end

  def create
    debugger
    @submission = Submission.new
    @form = Form.new(_type: "..", data: {})
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
