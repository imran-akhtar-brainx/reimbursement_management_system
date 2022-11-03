class Submission < ApplicationRecord
  validate :vault_balance
  belongs_to :user
  belongs_to :form
  enum status: [:approved, :pending, :rejected]
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  def vault_balance
    if Form.find(self.form_id)._type == "medical"
      submissions = user.submissions.where(form_id: Form.find_by(_type: "medical").id)
      balance = user.roles.first.medical_allowance - (user.total_generator(submissions))
      if balance < 0
        errors.add(:balance, "low balance")
      end
    end
  end
end
