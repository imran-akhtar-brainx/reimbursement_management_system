class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :form
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    enum status: [:approved, :pending, :rejected]
  end
end
