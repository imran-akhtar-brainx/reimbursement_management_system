class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.integer :_type
      t.float :medical_allowance, default: 0.0
      t.float :travel_allowance, default: 0.0
      t.float :fitness_allowance, default: 0.0
      t.float :dinner_allowance, default: 0.0
      t.timestamps
    end

    create_table :roles_users do |t|
      t.belongs_to :user
      t.belongs_to :role
    end

  end
end
