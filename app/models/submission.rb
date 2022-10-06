class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :form
  enum status: [:pending, :approved, :rejected]
end
