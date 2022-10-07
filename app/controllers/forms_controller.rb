class FormsController < ApplicationController

  def index
    @forms = Form.all
  end


  def submitted_forms
    @forms = Form.all
  end

end
