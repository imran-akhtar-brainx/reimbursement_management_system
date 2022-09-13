class AddPropertiesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :emp_id, :string
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :phone, :integer
    add_column :users, :department, :string
    add_reference :users, :manager, null: true, foreign_key: {to_table: :users}
  end
end
