class Role < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  enum _type: [:admin, :project_manager, :team_lead, :senior_software_engineer, :software_engineer, :accountant, :human_resource]
end