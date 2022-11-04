class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relations
  belongs_to :manager, class_name: "User", optional: true
  has_many :employees, class_name: "User", foreign_key: :manager_id
  has_and_belongs_to_many :roles
  has_many :submissions
  has_many :forms, through: :submissions

  def has_role?(role)
    roles.pluck(:_type).include?(role)
  end

  def role
    roles&.first&._type
  end

  def total_generator(submissions)
    sum = 0
    submissions.each do |submission|
      submission.data = submission.data.except('name_of_patient', 'relationship_with_employee', 'reporting_manager', 'name_of_patient', 'relationship_with_employee', 'project_name')
      submission.data.values.each do |key, value|
        sum += (key['amount'].to_i)
      end
    end
    sum
  end

end
