class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #relations
  belongs_to :manager, class_name: "User", optional: true
  has_and_belongs_to_many :roles
  has_many :submissions
  has_many :forms,  through: :submissions

  def has_role?(role)
    roles.pluck(:_type).include?(role)
  end
end

# class Submission < ApplicationRecord
#   belongs_to :user
#   belongs_to :form
# end


# class CreateSubmissions < ActiveRecord::Migration[7.0]
#   def change
#     create_table :submissions do |t|
#       t.belongs_to :user
#       t.belongs_to :form
#       t.as_json :data
#       # t.datetime :submission_date
#       t.timestamps
#     end
#   end
# end