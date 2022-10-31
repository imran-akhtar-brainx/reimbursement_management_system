class Submission < ApplicationRecord
  validate :vault_balance
  belongs_to :user
  belongs_to :form
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    enum status: [:approved, :pending, :rejected]
  end

  def vault_balance
    submissions = user.submissions.where(form_id: Form.find_by(_type: "medical").id)
    balance = user.roles.first.medical_allowance - (user.total_generator(submissions) + submission_total(self))
    if balance < 0 && Form.find(self.form_id)._type == "medical"
      errors.add(:balance, "low balance")
    end
  end

  private

  def submission_total(submission)
    sum = 0
    submission.data = submission&.data&.except('name_of_patient', 'relationship_with_employee', 'reporting_manager', 'name_of_patient', 'relationship_with_employee', 'project_name')
    submission&.data&.values&.each do |key, value|
      sum += (key['amount'].to_i)
    end
    sum
  end


end
