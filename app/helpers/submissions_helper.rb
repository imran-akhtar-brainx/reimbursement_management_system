module SubmissionsHelper
  def all_employees
    User.joins(:roles).where.not('roles._type' => 'admin').order(:id).pluck(:name, :id)
  end
  def all_forms
    Form.all.pluck(:_type, :id)
  end
end
