class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relations
  belongs_to :manager, class_name: "User", optional: true
  has_and_belongs_to_many :roles
  has_many :submissions
  has_many :forms, through: :submissions

  def has_role?(role)
    roles.pluck(:_type).include?(role)
  end

  def role
     roles&.first&._type.titleize
  end

end
